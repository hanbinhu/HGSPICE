*common source
*.prot
*.lib "log018.l" TT
*.unprot

vdd vdd 0 dc 1.8 ac 0
vcm vcm 0 dc 0.9
vin in vcm ac 1

M1 out in vdd vdd pch l=0.5u w=11u

Rl out 0 5k
Cl out 0 2p
.model pch PMOS

.op
.ac dec 10 1 1g
.end
