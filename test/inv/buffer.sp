*Inverter Test

vdd vdd 0 1.8
vin in 0 1

M1 1 in 0 0 NCH l = 1u w = 2u
M2 1 in vdd vdd PCH l = 1u w = 2u
M3 out 1 0 0 NCH l = 1u w = 2u
M4 out 1 vdd vdd PCH l = 1u w = 2u

.model NCH NMOS
.model PCH PMOS

.dc vin 0 1.8 0.01

.end
