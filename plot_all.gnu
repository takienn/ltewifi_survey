set terminal pngcairo enhanced font 'Verdana,10'
set output 'all_abs.png'

#set xdata time
#set timefmt "%S"
set xlabel "time(ms)"
set yrange [1:100]
set ytics (0,10,20,30,40,50,60,70,80,90,100)
set autoscale x;

set ylabel "Busy %";
#set format y "%s"
set title "Channel Busy % over time with different ABS types";

set style data lines;

set key right bottom;

plot "plot_abs0.dat" using 1:2 title "ABS0 transmission" lt rgb "green", \
     "plot_abs5.dat" using 1:2 title "ABS5 transmission" lt rgb "blue", \
     "plot_abs1.dat" using 1:2 title "ABS1 transmission" lt rgb "red"
