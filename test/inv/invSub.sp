*Inverter Test

vdd vdd 0 1.8
vin in 0 1

X1 in out vdd 0 INVCHAIN

.subckt INVCHAIN in out vdd gnd
X1 in 1 vdd gnd INV
X2 1 2 vdd gnd INV
X3 2 3 vdd gnd INV
X4 3 4 vdd gnd INV
X5 4 5 vdd gnd INV
X6 5 6 vdd gnd INV
X7 6 7 vdd gnd INV
X8 7 8 vdd gnd INV
X9 8 9 vdd gnd INV
X10 9 out vdd gnd INV
.ends

.subckt INV in out vdd gnd
M1 out in gnd gnd NCH l = 1u w = 2u
M2 out in vdd vdd PCH l = 1u w = 2u
.ends

.model NCH NMOS
.model PCH PMOS

.dc vin 0 1.8 0.01

.end
