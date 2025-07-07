`timescale 1ns/1ps

// Alguns erros:
// Carry in começa com 1'b1
// Depois de resolver o carry in, o resultado da soma dá +1
// 0 + 1 = 0?

module tb();

reg [3:0] num1; // A
reg [3:0] num2; // B
wire [3:0] out; // Resultado da soma S
wire cout; // Carry out

add u0 (
    .num1 (num1),
    .num2 (num2),
    .out  (out),
    .cout (cout)
);

integer i, j;

task testes;
    input [3:0] a, b;
    input [4:0] resultado; // 4 bits + carry out
    begin
        num1 = a;
        num2 = b;
        #1;
        if({cout, out} !== resultado) begin
            $display("Erro: %b + %b = %b (esperado: %b)", num1, num2, {cout, out}, resultado);
        end else begin
            $display("Teste OK: %b + %b = %b", num1, num2, {cout, out});
        end
    end
endtask

initial begin
    // $monitor("Decimal: num1 = %d, num2 = %d, out = %d, cout = %d || Binario: num1 = %b, num2 = %b, out = %b, cout = %b", num1, num2, out, cout, num1, num2, out, cout);
    $dumpfile("saida.vcd");
    $dumpvars(0, tb);

    for(i = 0; i < 16; i = i + 1) begin
        for(j = 0; j < 16; j = j + 1) begin
            testes(i, j, i + j);
        end
    end

    $finish;
end

endmodule