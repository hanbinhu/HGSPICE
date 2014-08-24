* staticDCStamp.sp

R1 1 0 0.1
G2 1 0 1 2 20

.subckt SUBR in out 
R3 in out 0.2 
.ends

X3 1 2 SUBR

R4 2 0 0.5
I5 0 2 1.2
V6 3 2 1.3
E7 0 4 2 1 30
R8 3 4 0.4

.op

.end
