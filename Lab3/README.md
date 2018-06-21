# Single-Cycle_CPU

## Architecture diagram :

![image](https://github.com/katelo731/CO_Lab/blob/master/Lab3/single_cycle_cpu.gif)

## Detailed description of the implementation :

這次的 Lab 相較於 Lab2 有三項主要變動：

    1. 增加了 Data_Memory 的模組，所以 Decoder 要多增加 3 條輸出，
       分別是 MemRead, MemWrite 與 MemToReg，依據指令是 LW 或是 SW 對應到不同的控制訊號。
  
    2. 支援 J, JAL 與 JR 指令，
    
       (1) J 指令：
           指令的 address 左移後與 PC+4 組合起來的值就是要 Jump 的位址，透過新增加的 MUX 判斷是否為 J 指令，傳給 PC。
           
       (2) JAL 指令：
           需要把 PC+4 寫入 $ra (R31) 裡，
           先把 Register 前的 MUX 從 2to1 改成 3to1，新增的位址選項是 R31 的位址，
           再透過增加 PC+4 當作 ALU 的輸入值，
           ALU 可以在收到 JAL 指令時直接輸出 PC+4 傳給 Register 當作 RegWB_data。
           
       (3) JR 指令：
           讀 Register 的 $ra (R31)，直接輸出要跳回的 address 給 PC。

    3. 支援更多Branch指令：
    
       BEQ   : ALU 透過減法運算，把 Alu_zero 輸入 4to1-MUX。
       BLE   : ALU 透過減法運算，把 Alu_zero | AluResult[31] 輸入 4to1-MUX。
       BLTZ  : ALU 直接輸出 Src1，把 AluResult[31] 輸入 4to1-MUX。
       BNEZ  : ALU 直接輸出 Src1，把 !Alu_zero 輸入 4to1-MUX。

## Instruction details :

### ALU Instructions from Lab2 :

    - AND
    - OR
    - ADD
    - SUB
    - SLT
    - SRA   : Shift right arithmetic
    - SRAV  : Shift right arithmetic variable

    - BEQ
    - ADDI
    - SLTIU : Set on less than immediate unsigned
    - ORI   : Or immediate

### ALU Instructions added in Lab3 :

    :: basic ::
    - LW
    - SW
    - J
    - MUL  : R-type
    
    :: bonus 1 ::
    - JAL  : jump and link
    - JR   : jump to the address in the register rs
    
    :: bonus 2 ::
    - BLE  : branch less equal than - if( rs <= rt ) then branch
    - BNEZ : branch non equal zero  - if( rs != 0 ) then branch (same as bne)
    - BLTZ : branch less than zero  - if( rs < 0 ) then branch
    - LI   : load immediate (same as addi)

