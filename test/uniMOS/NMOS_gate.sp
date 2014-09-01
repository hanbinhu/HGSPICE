*Unit Mos Test

vin gate 0 1
vd drain 0 1
M1 drain gate 0 0 NCH l = 1u w = 2u

.model NCH NMOS

.dc vin 0 1.8 0.01

.end
