# CO_Lab1
Lab1 of Computer Organization in NCTU


# Architecture diagram : 
![image](https://github.com/katelo731/32-bits_ALU/blob/master/32-bits_alu.jpg)


# Detailed description of the implementation :

### 1. ProgramCounter.v : (from TA)

    把 32-bit bus 從 pc_next 傳給 pc_data。

### 2. Adder.v :

    (1) Adder1 :
    
    得到的結果是 PC+4，也就是假設指令不需要 branch，先算好下一條指令的位址。
   
    (2) Adder2 :
    
    計算 branch 後對應指令的位址，是由 PC+4 和指令的 immediate 值(Sign-Extend 後)相加。

### 3. Instr_Memory.v : (from TA)

    讀 address 並輸出指令。

### 4. MUX_2to1.v :

  #### (1) Mux_Write_Reg :
   
    R-type 與 I-type 兩種指令要寫入 register 的 address 來源不同，所以需要這個 Mux 來選擇address 的來源。
    Mux 透過 Decoder 判斷型別並傳回的值(RegDst_ctrl)，選擇要寫入來自於instr_rt 或 instr_rd 的 address。

   #### (2) Mux_ALUSrc :

    指令的型態不同讓 ALU 的第二筆資料來源不同，所以需要這個 Mux 來選擇資料是來自於 register 或是 sign-extend 後的 immediate value。

   #### (3) Mux_PC_Source :

    這個 Mux 的功能是選擇下一筆指令的位址，如果不需要 branch，就選擇來自 Adder1 的位址，如果需要 branch，就選擇來自 Adder2 的位址。
    控制選擇的訊號來自於 Decoder 的 Branch_ctrl 跟 Alu_zero 進行 AND 後的結果，因為即使Decoder 判斷需要 branch，
    但 ALU 的結果有可能不符合跳轉條件(例如指令是 BEQ 但 rs != rt)，所以需要 AND 確定跳轉條件都符合。

### 5. Reg_File.v : (from TA)

   由 Decoder 傳來的 RegWrite_ctrl 決定指令要不要寫資料進 register。

### 6. Decoder.v :

   由 instr_op 判斷每一種指令的型別，並輸出對應的控制訊號給 Mux 與 ALU Control。

### 7. ALU_Ctrl.v :
 
   接收 Decoder 的訊號，如果指令是 R-type，需要再根據 instr_funct 判斷指令的意義，
   如果指令是 I-type，就直接取 ALUOp_Ctrl 的值判斷 ALU 要做甚麼運算。

### 8. Sign_Extend.v :

   指令的 immediate value 只有 16 bits，但在其他地方的運算都需要 32 bits，所以需要把 MSB(sign bit)填滿前面 16 bits。

### 9. ALU.v :

   所有的算術運算都在這裡執行，在這裡我直接用運算子計算。

### 10. Shift_Left_Two_32.v :

   將 Sign-extend 後的 immediate value 左移兩位。

### 11. Simple_Single_CPU.v :

   Top module，連接所有的 sub-module。
