**PMOS input stage CS output stage amplifier

vdd vdd 0 dc 1.8 ac 0 
vcm vcm 0 dc 0.7 ac 0
vin1 in1 vcm 0 ac 1
vin2 in2 vcm 0 ac 0
Ibias Iin 0 dc 10u

**amplifier
**first stage
M1 y in1 tail vdd pch l=0.5u w=20u
M2 x in2 tail vdd pch l=0.5u w=20u
M3 y x 0 0 nch l=0.5u w=5u
M4 x x 0 0 nch l=0.5u w=5u
M5 tail Iin vdd vdd pch l=0.5u w=48u

**second stage
M6 out y 0 0 nch l=0.5u w=30u
M7 out Iin vdd vdd pch l=0.5u w=144u

**bias
M8 Iin Iin vdd vdd pch l=0.5u w=3u

**compensation
Rz y z 1.75k
Cc z out 350f

**Load
Cl out 0 2p

.model pch PMOS
.model nch NMOS

.ac dec 10 1 1G

.end
