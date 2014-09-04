*Unit Mos Test

vdd vdd 0 1.8
vin in 0 0.9

Rload vdd out 10k
M1 out in 0 0 NCH l = 1u w = 2u

.model NCH NMOS

.dc vin 0 1.8 0.01

.end
