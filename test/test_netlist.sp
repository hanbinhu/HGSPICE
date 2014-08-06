*Parser Test 

vdd vdd 0 1.8

R1 vdd 1 5k
C1 1 0 500f
L1 1 ab 2n
E1 3 2 1 2 1Meg
F1 fe 2 vsen 1u
g1 fe gg 1 2 1k
H1 fe hg vsen 1T
D5 n1 n2 diode
Mn1 d1 g1 s1 b1 NCH l = 10u w = 20u
Mp2 d2 g2 s2 b2 PCH w = 20u l = 10u
R2 ab c 2
Ila c 0 1m

.op
.dc vdd 0 1.8 0.1
.ac DEC 10 10k 1G
.Tran 1n 1u

.end
