
`timescale 1ns / 100ps

module sim_1;

    reg clk, reset;
    reg [2:0] muones;
    reg [31:0] gpo1;
    reg [31:0] gpo2;
    wire int_mcs;
    wire [31:0] gpi1;
    
    logic_block_inst_0 up1 (
    .clk(clk),
    .gpi1(gpi1),
    .gpo1(gpo1),
    .gpo2(gpo2),
    .int_mcs(int_mcs),
    .muon_count(muones),
    .reset(reset)
    );
    
    always begin 
    #5; //CLOCK DE 100MHz (10ns de periodo)
    clk = ~clk;
    end
    
    initial begin 
    //RESET
    #150; //TIEMPO DE ESTABLECIMIENTO DE VARIABLES GLOBALES
    reset = 1;
    clk = 1;
    #20;
    reset = 0; 
    
    //VALORES INICIALES
    // 10ms de TM y raw_input en 0 todo
    gpo1 = 'h80000000;  //Enable del reg32 para enviar divisor al divisor de freq
    gpo2 = 'h000001F4;  //500 de TM y 1 bit de enable.
    muones = 'h0;    //raw_input en 0 todos
    #40;
    gpo1 = 32'b00000000000000000000000000000000;         //Enable off
    gpo2 = 'h0;         //0 en GPO
    #20;
   
    //PRUEBAS 
    muones = 'h001002;   //1er grado +
    #15;
    muones = 'h0;        //NADA
    #15;
    muones = 'h001001;   //90 grados
    #15;
    muones = 'h0;        //NADA
    #15;
    muones = 'h001001;   //90 grados
    #15;
    muones = 'h0;        //NADA
    #15;
    muones = 'h001001;   //90 grados
    #15;
    muones = 'h0;        //NADA
    #15;
    muones = 'h001001;   //90 grados
    #15;
    muones = 'h0;        //NADA
    #15;
    
    
    muones = 'h002001;   //1er grado-
    #15;
    muones = 'h0;        //NADA
    #15;
    muones = 'h002001;   //1er grado-
    #15;
    muones = 'h0;        //NADA
    #15;
    muones = 'h002001;   //1er grado-
    #15;
    muones = 'h0;        //NADA0
    #15;
    
    #4730;
    
    //LEYENDO GPI
    gpo1 = 'h1;  //Seleccionando canal 0 
    #20;
    //SE REVISA GPI (4)
    gpo1 = 32'b00000000000000000000000000000000;         //Enable off
    #10
    
    gpo1 = 'h2;  //Seleccionando canal 1
    #20;
    //SE REVISA GPI (0)
    gpo1 = 32'b00000000000000000000000000000000;         //Enable off
    #10;
    
    gpo1 = 'h3;  //Seleccionando canal 2
    #20;
    //SE REVISA GPI (4)
    gpo1 = 32'b00000000000000000000000000000000;         //Enable off
    #10;
    
    gpo1 = 'h4;  //Seleccionando canal 3
    #20;
    //SE REVISA GPI (0)
    gpo1 = 32'b00000000000000000000000000000000;         //Enable off
    #10;
    
    gpo1 = 'h5;  //Seleccionando canal 4
    #20;
    //SE REVISA GPI (0)
    gpo1 = 32'b00000000000000000000000000000000;         //Enable off
    #10;
    
    gpo1 = 'h18;  //Reseteamos registro
    #20;
    //SE REVISA GPI (0)
    gpo1 = 32'b00000000000000000000000000000000;         //Enable off
    #10;
    
    end 
    
endmodule
