#!/usr/bin/gnuplot

#General Setting
set terminal postscript enhanced "Helvetica" 15 color
set datafile separator ","
set grid
set key box left bottom

set output "1.eps"

set ylabel "Current(A)"

data="tmpI.csv"
