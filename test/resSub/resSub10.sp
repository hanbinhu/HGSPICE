* resSub

Vin 1 0 1024

R1 1 in 1
X1 in out 0 SUBR10
Rload out 0 1

.subckt SUBR in out gnd
Rio in out 1
Rig in gnd 2
.ends

.subckt SUBR10 in out gnd
X1 in 1 gnd SUBR
X2 1 2 gnd SUBR
X3 2 3 gnd SUBR
X4 3 4 gnd SUBR
X5 4 5 gnd SUBR
X6 5 6 gnd SUBR
X7 6 7 gnd SUBR
X8 7 8 gnd SUBR
X9 8 9 gnd SUBR
X10 9 out gnd SUBR
.ends

.op

.end
