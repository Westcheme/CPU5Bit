|     Instruction     | Opcode | Instruction Type |      Operation       |
| ------------------- | ------ | ---------------- | -------------------- |
| Add                 |  0000  |      R-Type      | $rw = $rr1 + $rr2    |
| Add Immediate       |  0001  |      I-Type      | $rw = $rr1 + imm     |
| Subtract            |  0010  |      R-Type      | $rw = $rr1 - $rr2    |
| Multiply            |  0011  |      R-Type      | hi,lo = $rr1 * $rr2  |
| Divide              |  0100  |      R-Type      | lo = $rr1 / $rr2     |
|                     |        |                  | hi = $rr1 rem $rr2   |
| AND                 |  0101  |      R-Type      | $rw = $rr1 AND $rr2  |
| OR                  |  0110  |      R-Type      | $rw = $rr1 OR $rr2   |
| XOR                 |  0111  |      R-Type      | $rw = $rr1 XOR $rr2  |
| NOR                 |  1000  |      R-Type      | $rw = $rr1 NOR $rr2  |
| NAND                |  1001  |      R-Type      | $rw = $rr1 NAND $rr2 |
| Shift Left Logical  |  1010  |      R-Type      | $rw = $rr1 << shamt  |
| Shift Right Logical |  1011  |      R-Type      | $rw = $rr1 >> shamt  |
| Rotate Left         |  1100  |      R-Type      | $rw = $rr1 << shamt  |
| Rotate Right        |  1101  |      R-Type      | $rw = $rr1 >> shamt  |
| AND Immediate       |  1110  |      I-Type      | $rw = $rr1 AND imm   |
| OR Immediate        |  1111  |      I-Type      | $rw = $rr1 OR imm    |

![image](E:\School & Career\School\Winter 2021\ECE 475\Labs\Final Project\R Type Instruction Format.png)
![image](E:\School & Career\School\Winter 2021\ECE 475\Labs\Final Project\I Type Instruction Format.png)
