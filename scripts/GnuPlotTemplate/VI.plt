#!/usr/bin/gnuplot

#General Setting
set terminal postscript enhanced "Helvetica" 15 color
set datafile separator ","
set grid
set key box left bottom

set output "1.eps"

set ylabel "Voltage(V)"

set y2label "Current(A)"
set y2tics
set ytics nomirror

dataV="tmpV.csv"
dataI="tmpI.csv"
