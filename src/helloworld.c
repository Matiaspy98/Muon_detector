//Librerias
#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"
#include "xgpio.h"
#include "xintc_l.h"
#include "xstatus.h"
#include "xparameters.h"
#include "xil_exception.h"
#include "xuartlite_l.h"
#include <math.h>
#include "sleep.h"
#include "xspi.h"
#include "xspi_l.h"

//Variables y parametros globales
u32 intc_mask = XPAR_LOGIC_BLOCK_1_POSEDGE_DETECT_3_DET_MASK | XPAR_AXI_UARTLITE_0_INTERRUPT_MASK;	//Mascara para el enable de interrupcion
char tm = '1';
const u8 command = 0x04; //B00000100
#define SPI_DEVICE_ID       XPAR_SPI_0_DEVICE_ID
XSpi device;
const u8 enableUpdateMSB = 0x1C; //B00011100
const u8 enableUpdateLSB = 0x02; //B00000010
u8 bytes2 [2] = {enableUpdateMSB,enableUpdateLSB};
//Instancias
XGpio leds; 																			//LEDS (gpo)						-> GPIO3
XGpio gpi; 																				//GPI entre micro y logica			-> GPIO0
XGpio gpo1; 																			//GPO1 entre  micro y Logica		-> GPIO2 BUS DE DATOS
XGpio gpo2;																				//GPO2 entre micro y logica			-> GPIO1 ENABLE Y SELECTOR
void init_gpios();																		//Funcion para incializar GPIOs
void init_interruptions();	//Funcion para inicializar interrupciones
void init_spi();
void logic_interruption(void *CallbackRef);												//Funcion que se implementa cada tm (tiempo de muestreo)
void uart_interruption(void *baseaddr_p);												//Funcion que se implementa cada vez que se recibe un dato por UART
void assing_tm(char tm);																//Funcion para asignar un tiempo de muestreo
void input_test(int ch, int quant);
//Funcion que envia en "ch" canal "quant" pulsos en 500us (0.5ms) o menos
void enablepot(char csPin);
void potWrite(char csPin, int value);
void gpi_read();																		//Funcion que lee el GPI del MicroBlaze 3 veces
u32 sel_mux(int ch);																	//Funcion auxiliar
u32 getUARTdata();																		//Extraer input del UART

int main(void)
{
    init_platform();
    usleep(500000);
    init_gpios();
    usleep(500000);
    assing_tm('1');
    usleep(500000);
    init_interruptions();
    usleep(100000);
    init_spi();
    while(1) {
    	//usleep(2000000);

    	//INPUTS DE PRUEBA
    	/*input_test(25, 1);
    	usleep(1);
    	for (int i = 0 ; i < 23 ; i++) {
    		input_test(i, 3);
    		usleep(1);
    	}
    	print("Test-inputs enviados.\n\r");
    	usleep(5000000);*/

    	//LECTURA
    	//gpi_read();

    }
    cleanup_platform();
    return 0;
}
void init_gpios() {
	//GPIO_3 -> LEDS
	XGpio_Initialize(&leds, XPAR_AXI_GPIO_3_DEVICE_ID);
	XGpio_SetDataDirection(&leds, 1, 0x0);

	//GPIO_0 -> GPI uBlaze/Logic
	XGpio_Initialize(&gpi, XPAR_AXI_GPIO_0_DEVICE_ID);
	XGpio_SetDataDirection(&gpi, 1, 0xFFFFFFFF);

	//GPIO_2 -> GPO1 uBlaze/Logic BUS DE DATOS
	XGpio_Initialize(&gpo1, XPAR_AXI_GPIO_2_DEVICE_ID);
	XGpio_SetDataDirection(&gpo1, 1, 0x0);

	//GPIO_1 -> GPO2 uBlaze/Logic ENABLE Y SELECTOR
	XGpio_Initialize(&gpo2, XPAR_AXI_GPIO_1_DEVICE_ID);
	XGpio_SetDataDirection(&gpo2, 1, 0x0);}

void init_spi(){
//INICIO SPI
int Status;
XSpi_Config *ConfigPtr;
ConfigPtr = XSpi_LookupConfig(XPAR_AXI_QUAD_SPI_1_DEVICE_ID);

//prueba de puerto.
if (ConfigPtr == NULL) {
xil_printf("No se encontro el SPI\n\r");
}

//prueba de inicializacion.
Status = XSpi_CfgInitialize(&device, ConfigPtr,
			  ConfigPtr->BaseAddress);
if (Status != XST_SUCCESS) {
	xil_printf("falla al iniciar SPI\n\r");
}

xil_printf("SPI listo. \n\r");

XSpi_CfgInitialize(&device, ConfigPtr, ConfigPtr->BaseAddress);
XSpi_SetOptions(&device, XSP_MASTER_OPTION | XSP_CLK_ACTIVE_LOW_OPTION | XSP_CLK_PHASE_1_OPTION | XSP_MANUAL_SSELECT_OPTION);
XSpi_Start(&device);
XSpi_IntrGlobalDisable(&device);
}
void enablepot( char csPin){
	int Status;
	switch (csPin) {
		case '1': {
			xil_printf("entro enable 1 \n\r");
			Status =XSpi_SetSlaveSelect(&device, 0x01);
			if(Status != XST_SUCCESS) {
				xil_printf("NO SE PUDO enable 1 \n\r");}
			break;
		}
		case '2': {
			xil_printf("entro enable 2 \n\r");
			XSpi_SetSlaveSelect(&device, 0x02);
			break;
		}
		case '3': {
			xil_printf("entro enable 3 \n\r");
			XSpi_SetSlaveSelect(&device, 0x03);
			break;
		}
		case '4': {
			xil_printf("entro enable 4 \n\r");
			XSpi_SetSlaveSelect(&device, 0x04);
			break;
		}
		default: {
			XSpi_SetSlaveSelect(&device, 0x01);
			break;}};
	XSpi_Transfer(&device, bytes2, NULL, 2);
}
void potWrite(char csPin, int value){
	int Status;
	switch (csPin) {
		case '1': {
			xil_printf("entro write 1 \n\r");
			Status =XSpi_SetSlaveSelect(&device, 0x01);
			if(Status != XST_SUCCESS) {
				xil_printf("NO SE PUDO write 1 \n\r");
				}
			break;
		}
		case '2': {
			XSpi_SetSlaveSelect(&device, 0x02);
			break;
		}
		case '3': {
			XSpi_SetSlaveSelect(&device, 0x03);
			break;
		}
		case '4': {
			XSpi_SetSlaveSelect(&device, 0x04);
			break;
		}
		default: {
			XSpi_SetSlaveSelect(&device, 0x01);
			break;}}
	u8 byte1;
	u8 shiftedvalue = value >> 8;
	byte1 = command | shiftedvalue;
	u8 byte0;
	byte0 = (value & 0xFF) ;
	//0xFF = B11111111 trunicates value to 8 bits
	u8 bytes [2] = {byte1,byte0};
	XSpi_Transfer(&device, bytes, NULL, 2);
    usleep(1);
}
void init_interruptions() {
	microblaze_enable_interrupts();
	XIntc_RegisterHandler(XPAR_INTC_0_BASEADDR,
						  XPAR_MICROBLAZE_0_AXI_INTC_LOGIC_BLOCK_1_POSEDGE_DETECT_3_DET_INTR,
						  (XInterruptHandler)logic_interruption,
						  (void *)0);
	XIntc_RegisterHandler(XPAR_INTC_0_BASEADDR,
					   	  XPAR_MICROBLAZE_0_AXI_INTC_AXI_UARTLITE_0_INTERRUPT_INTR,
						  (XInterruptHandler)uart_interruption,
						  (void *)XPAR_AXI_UARTLITE_0_BASEADDR);
	XIntc_MasterEnable(XPAR_INTC_0_BASEADDR);
	XIntc_EnableIntr(XPAR_INTC_0_BASEADDR, 0x3);
	XUartLite_EnableIntr(XPAR_AXI_UARTLITE_0_BASEADDR);
}

void logic_interruption(void *CallbackRef) {
	//print("Leyendo datos...\n\r");
	gpi_read();
	/*XGpio_DiscreteWrite(&leds, 1, 1);
	print("01\n\r");
	usleep(1000000);
	XGpio_DiscreteWrite(&leds, 1, 2);
	print("10\n\r");
	usleep(1000000);
	XGpio_DiscreteWrite(&leds, 1, 0);*/

}

void uart_interruption(void *baseaddr_p) {
	if (!XUartLite_IsReceiveEmpty(XPAR_AXI_UARTLITE_0_BASEADDR)) {
		//print("Ingrese el tiempo de muestreo (T?)\n\r");
		char a, b, c;
		//u32 data_input;
		//interrumpir la toma de muestras
		a = XUartLite_RecvByte(XPAR_AXI_UARTLITE_0_BASEADDR);
		switch (a) {
			case 'T': {
				b = XUartLite_RecvByte(XPAR_AXI_UARTLITE_0_BASEADDR);
				assing_tm(b);
				print("Tiempo de muestreo actualizado.\n\r");
				//bandera_pausa='0';
				break;
			}
			case 'P': {
				b = XUartLite_RecvByte(XPAR_AXI_UARTLITE_0_BASEADDR);//b seria el csPin
				c = XUartLite_RecvByte(XPAR_AXI_UARTLITE_0_BASEADDR);//c seria el valor
				enablepot(b);
				potWrite(b,c);
			    usleep(500000);
				//bandera_pausa = '0';
			    //XGpio_DiscreteWrite(&gpo2, 1, 0x0);//supongo que esto resetea las cuentas de los bloques logicos
			   // usleep(1);
				break;
			}
			default: {
				//bandera_pausa='0';
				//print("Error \n\r");
				break;
			}
		}
	}
}


void assing_tm(char tm) {
	/*
	0) 0x00989680 -> 100 ms (default)
	1) 0X05F5E100 ->   1 s
	2) 0x0BEBC200 ->   2 s
	5) 0x1DCD6500 ->   5 s
	*/
	switch (tm) {
		case '0': {
			usleep(10);
			XGpio_DiscreteWrite(&gpo2, 1, 0x80000000);
			usleep(1);
			XGpio_DiscreteWrite(&gpo1, 1, 0x00989680);
			usleep(1);
			XGpio_DiscreteWrite(&gpo2, 1, 0x0);
			XGpio_DiscreteWrite(&gpo1, 1, 0x0);
			xil_printf("Tiempo de muestreo = 100 ms \n\r");
			break;
		}
		case '1': {
			usleep(10);
			XGpio_DiscreteWrite(&gpo2, 1, 0x80000000);
			usleep(1);
			XGpio_DiscreteWrite(&gpo1, 1, 0X05F5E100);
			usleep(1);
			XGpio_DiscreteWrite(&gpo2, 1, 0x0);
			XGpio_DiscreteWrite(&gpo1, 1, 0x0);
			xil_printf("Tiempo de muestreo = 1 s \n\r");
			break;
		}
		case '2': {
			usleep(10);
			XGpio_DiscreteWrite(&gpo2, 1, 0x80000000);
			usleep(1);
			XGpio_DiscreteWrite(&gpo1, 1, 0x0BEBC200);
			usleep(1);
			XGpio_DiscreteWrite(&gpo2, 1, 0x0);
			XGpio_DiscreteWrite(&gpo1, 1, 0x0);
			xil_printf("Tiempo de muestreo = 2 s \n\r");
			break;
		}
		case '5': {
			usleep(10);
			XGpio_DiscreteWrite(&gpo2, 1, 0x80000000);
			usleep(1);
			XGpio_DiscreteWrite(&gpo1, 1, 0x1DCD6500);
			usleep(1);
			XGpio_DiscreteWrite(&gpo2, 1, 0x0);
			XGpio_DiscreteWrite(&gpo1, 1, 0x0);
			usleep(1);
			xil_printf("Tiempo de muestreo = 5 s \n\r");
			break;}

		default: {
			usleep(10);
			XGpio_DiscreteWrite(&gpo2, 1, 0x80000000);
			usleep(1);
			XGpio_DiscreteWrite(&gpo1, 1, 0x00989680);
			usleep(1);
			XGpio_DiscreteWrite(&gpo2, 1, 0x0);
			XGpio_DiscreteWrite(&gpo1, 1, 0x0);
			usleep(1);
			xil_printf("Tiempo de muestreo = 1 s \n\r");
			break;
		}
	}
	usleep(1);
}

void input_test(int ch, int quant) {
	u32 hex_input;
	switch (ch) {
		case 0: {
					hex_input = 0x001001;
					break;
				}
		case 1: {
					hex_input = 0x001002;
					break;
		}
		case 2: {
					hex_input = 0x002001;
					break;
				}
		case 3: {
					hex_input = 0x001004;
					break;
				}
		default: {
					hex_input = 0x0;
					break;
				}

	}
	for (int j = 0 ; j < quant ; j++) {
		XGpio_DiscreteWrite(&gpi, 1, hex_input);
		usleep(1);
		XGpio_DiscreteWrite(&gpi, 1, 0x0);
		usleep(1);
	}
	xil_printf("Input: %d pulsos en canal %d \n\r", quant, ch);
}

void gpi_read() {
	u32 data;
	for (int k = 0 ; k < 5 ; k++) {
		XGpio_DiscreteWrite(&gpo2, 1, sel_mux(k));
	    usleep(1);
	    data = XGpio_DiscreteRead(&gpi, 1);
	    xil_printf("%d ", data);
	    usleep(1);
	    XGpio_DiscreteWrite(&gpo2, 1, 0x0);
	    usleep(1);
	}
	xil_printf(";");
	xil_printf("\n");
}

u32 sel_mux(int ch) {
	u32 mask_output;
	switch (ch) {
	case 0: {
			mask_output = 0x1;
			break;
		}
	case 1: {
			mask_output = 0x2;
			break;
		}
	case 2: {
			mask_output = 0x3;
			break;
		}
	case 3: {
			mask_output = 0x4;
			break;
		}
	case 4: {
			mask_output = 0x5;
			break;
	}
	default: {
			mask_output = 0x0;
			break;
			}
	}
	return mask_output;
}

u32 getUARTdata() {
	u32 data = 0;
	return data;
}



