*Parser Test 

vdd vdd 0 1.8

R1 vdd 1 5k
C1 1 oct 500f 3.3
Cc 4 dec 3p 0.1
L1 1 gnd 2n 3m
Lcc 2 gNd 3n
E1 3 2 1 2 1Meg
F1 fe 2 vsen 1u
g1 fe gg 1 2 1k
H1 fe hg vsen 1T
D5 n1 n2 diode
Mn1 d1 g1 s1 b1 NCH l = 10u w = 20u
Mp2 d2 g2 s2 b2 PCH w = 20u l = 10u
R2 1 0 2
Rex vdd 1 39
Ila c 0 1m ac 2 30 sin 0 1 100Meg 1n 1G
I1 c 0 pulse -1 1 2n 2n 2n 50n 100n
I2 c 0 ac 2 exp -4 -1 2n 30n 60n 40n
I3 c 0 1 SFFM 0 1 10k 5 1k
I4 c 0 3
vsen vdd 0 dc 1 ac 1 sin 1 1 20k 1n 0

Xs fie ji vdd 0 INV

.model PCH PMOS
.model NCH NMOS
.model diode d

.subckt INV in out vdd gnd L=5n W=5u s=10
R1 vdd 1 5k
V4 in out 0
XXs fie foef in vdd INV1 L=4 p=3
.ends

.subckt INV1 in out vdd gnd L=5n W=5u s=10
R1 vdd 1 5k
V4 in out 0
.ends

.op
.dc vdd 0 1.8 0.1
.ac LIN 10 10k 1G
.ac DEC 100 10 1Meg
.Tran 1n 1u

.end
