* resSub

Vin 1 0 1024

R1 1 in 1
X1 in out 0 SUBR4
Rload out 0 1

.subckt SUBR in out gnd
Rio in out 1
Rig in gnd 2
.ends

.subckt SUBR2 in out gnd
X1 in 1 gnd SUBR
X2 1 out gnd SUBR
.ends

.subckt SUBR4 in out gnd
X1 in 1 gnd SUBR2
X2 1 out gnd SUBR2
.ends

.op

.end
