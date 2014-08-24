* resSub

Vin 1 0 1024

R1 1 in 1
X1 in out 0 SUBR
Rload out 0 1

.subckt SUBR in out gnd
Rio in out 1
Rig in gnd 2
.ends

.op

.end
