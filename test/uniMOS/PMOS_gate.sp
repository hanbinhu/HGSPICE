*Unit Mos Test

vdd vdd 0 1.8
vin gate 0 1
vd drain 0 0.8
M1 drain gate vdd vdd PCH l = 1u w = 2u

.model PCH PMOS

.dc vin 0 1.8 0.01

.end