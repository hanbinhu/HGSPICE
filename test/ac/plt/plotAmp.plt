#!/usr/bin/gnuplot
set terminal postscript enhanced eps color solid "Times-Roman,21"
set datafile separator ","
set output "1.eps"
set logscale x
set xtics ("1" 1e0, "10" 1e1, "100" 1e2,\
"1K" 1e3, "10K" 1e4, "100K" 1e5,\
"1M" 1e6, "10M" 1e7, "100M" 1e8, "1G" 1e9)
set xlabel "Frequency (Hz)"
set ylabel "Gain (dB)"
set y2label "Phase"
set y2tics
set ytics nomirror
set grid
set key box left bottom
set key Right
set key spacing 1.5

set style line 1 lc rgb "black" lw 5
set style line 2 lc rgb "blue" lw 5
set style line 4 lt 0 lc rgb "black" lw 5
set style line 5 lt 0 lc rgb "blue" lw 5

plot "PMOS_CS.lis" u 1:(log10($2)*20) t "|H_{BSIM}(s)|" w l ls 1 axis x1y1,\
     "opamp_ac0.csv" u 1:(log10($20)*20) t "|H_{EKV}(s)|" w l ls 2 axis x1y1,\
     "PMOS_CS.lis" u 1:3 t "{/Symbol=16 \320}H_{BSIM}(s)" w l ls 4 axis x1y2,\
     "opamp_ac0.csv" u 1:21 t "{/Symbol=16 \320}H_{EKV}(s)" w l ls 5 axis x1y2,\
