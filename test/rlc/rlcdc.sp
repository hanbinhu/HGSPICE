* RLC

vin vin 0 1.8

.op
R1 vin out 10k
L1 out 0 5n
C1 out 0 1p

.dc vin 0 1.8 0.9
.op
.dc vin 0 1.8 0.6

.end
