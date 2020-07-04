#!/bin/sh

for opt in "0.1" "0.5" "1"
do
	name="01"
	if test $opt = "0.1"; then
		name="10"
	fi
	if test $opt = "0.5"; then
		name="50"
	fi
	if test $opt = "1"; then
		name="100"
	fi
#1a
	gnuplot -persist <<-EOFMarker
		set terminal png
		set output "grafici/opt_${name}_pdr_cvorovi_s2.png"
		set xlabel "Broj čvorova"
		set autoscale
		set ylabel "Packet Delivery Ratio"
		set grid
		set style data linespoints
		set key outside;
		set key right center;
		plot "${opt}/nodes/s2/prot_0_pdr.txt" using 1:2 title "AODV" lw 2 linecolor rgb "red", "${opt}/nodes/s2/prot_1_pdr.txt" using 1:2 title "DSDV" lw 2 linecolor rgb "green", "${opt}/nodes/s2/prot_2_pdr.txt" using 1:2 title "OLSR" lw 2 linecolor rgb "orange", "${opt}/nodes/s2/prot_3_pdr.txt" using 1:2 title "DSR" lw 2 linecolor rgb "blue"
	EOFMarker
#1b
	gnuplot -persist <<-EOFMarker
		set terminal png
		set output "grafici/opt_${name}_jitter_cvorovi_s2.png"
		set xlabel "Broj čvorova"
		set autoscale
		set ylabel "Jitter (s)"
		set grid
		set style data linespoints
		set key outside;
		set key right center;
		plot "${opt}/nodes/s2/prot_0_jitter.txt" using 1:2 title "AODV" lw 2 linecolor rgb "red", "${opt}/nodes/s2/prot_1_jitter.txt" using 1:2 title "DSDV" lw 2 linecolor rgb "green", "${opt}/nodes/s2/prot_2_jitter.txt" using 1:2 title "OLSR" lw 2 linecolor rgb "orange", "${opt}/nodes/s2/prot_3_jitter.txt" using 1:2 title "DSR" lw 2 linecolor rgb "blue"
	EOFMarker
#1c	
	gnuplot -persist <<-EOFMarker
		set terminal png
		set output "grafici/opt_${name}_throughput_cvorovi_s2.png"
		set xlabel "Broj čvorova"
		set autoscale
		set ylabel "Throughput (Kbps)"
		set grid
		set style data linespoints
		set key outside;
		set key right center;
		plot "${opt}/nodes/s2/prot_0_throughput.txt" using 1:2 title "AODV" lw 2 linecolor rgb "red", "${opt}/nodes/s2/prot_1_throughput.txt" using 1:2 title "DSDV" lw 2 linecolor rgb "green", "${opt}/nodes/s2/prot_2_throughput.txt" using 1:2 title "OLSR" lw 2 linecolor rgb "orange", "${opt}/nodes/s2/prot_3_throughput.txt" using 1:2 title "DSR" lw 2 linecolor rgb "blue"
	EOFMarker
#1d
	gnuplot -persist <<-EOFMarker
		set terminal png
		set output "grafici/opt_${name}_delay_cvorovi_s2.png"
		set xlabel "Broj čvorova"
		set autoscale
		set ylabel "Kašnjenje (s)"
		set grid
		set style data linespoints
		set key outside;
		set key right center;
		plot "${opt}/nodes/s2/prot_0_delay.txt" using 1:2 title "AODV" lw 2 linecolor rgb "red", "${opt}/nodes/s2/prot_1_delay.txt" using 1:2 title "DSDV" lw 2 linecolor rgb "green", "${opt}/nodes/s2/prot_2_delay.txt" using 1:2 title "OLSR" lw 2 linecolor rgb "orange", "${opt}/nodes/s2/prot_3_delay.txt" using 1:2 title "DSR" lw 2 linecolor rgb "blue"
	EOFMarker
#1e
	gnuplot -persist <<-EOFMarker
		set terminal png
		set output "grafici/opt_${name}_overhead_cvorovi_s2.png"
		set xlabel "Broj čvorova"
		set autoscale
		set ylabel "Normalizirano opterećenje usmjeravanja"
		set grid
		set style data linespoints
		set key outside;
		set key right center;
		plot "${opt}/nodes/s2/prot_0_overhead.txt" using 1:2 title "AODV" lw 2 linecolor rgb "red", "${opt}/nodes/s2/prot_1_overhead.txt" using 1:2 title "DSDV" lw 2 linecolor rgb "green", "${opt}/nodes/s2/prot_2_overhead.txt" using 1:2 title "OLSR" lw 2 linecolor rgb "orange", "${opt}/nodes/s2/prot_3_overhead.txt" using 1:2 title "DSR" lw 2 linecolor rgb "blue"
	EOFMarker
	
	
	
#2a
gnuplot -persist <<-EOFMarker
		set terminal png
		set output "grafici/opt_${name}_pdr_cvorovi_s20.png"
		set xlabel "Broj čvorova"
		set autoscale
		set ylabel "Packet Delivery Ratio"
		set grid
		set style data linespoints
		set key outside;
		set key right center;
		plot "${opt}/nodes/s20/prot_0_pdr.txt" using 1:2 title "AODV" lw 2 linecolor rgb "red", "${opt}/nodes/s20/prot_1_pdr.txt" using 1:2 title "DSDV" lw 2 linecolor rgb "green", "${opt}/nodes/s20/prot_2_pdr.txt" using 1:2 title "OLSR" lw 2 linecolor rgb "orange", "${opt}/nodes/s20/prot_3_pdr.txt" using 1:2 title "DSR" lw 2 linecolor rgb "blue"
	EOFMarker
#2b
	gnuplot -persist <<-EOFMarker
		set terminal png
		set output "grafici/opt_${name}_delay_cvorovi_s20.png"
		set xlabel "Broj čvorova"
		set autoscale
		set ylabel "Kašnjenje (s)"
		set grid
		set style data linespoints
		set key outside;
		set key right center;
		plot "${opt}/nodes/s20/prot_0_delay.txt" using 1:2 title "AODV" lw 2 linecolor rgb "red", "${opt}/nodes/s20/prot_1_delay.txt" using 1:2 title "DSDV" lw 2 linecolor rgb "green", "${opt}/nodes/s20/prot_2_delay.txt" using 1:2 title "OLSR" lw 2 linecolor rgb "orange", "${opt}/nodes/s20/prot_3_delay.txt" using 1:2 title "DSR" lw 2 linecolor rgb "blue"
	EOFMarker
#2c
	gnuplot -persist <<-EOFMarker
		set terminal png
		set output "grafici/opt_${name}_overhead_cvorovi_s20.png"
		set xlabel "Broj čvorova"
		set autoscale
		set ylabel "Normalizirano opterećenje usmjeravanja"
		set grid
		set style data linespoints
		set key outside;
		set key right center;
		plot "${opt}/nodes/s20/prot_0_overhead.txt" using 1:2 title "AODV" lw 2 linecolor rgb "red", "${opt}/nodes/s20/prot_1_overhead.txt" using 1:2 title "DSDV" lw 2 linecolor rgb "green", "${opt}/nodes/s20/prot_2_overhead.txt" using 1:2 title "OLSR" lw 2 linecolor rgb "orange", "${opt}/nodes/s20/prot_3_overhead.txt" using 1:2 title "DSR" lw 2 linecolor rgb "blue"
	EOFMarker
	
#2d
	gnuplot -persist <<-EOFMarker
		set terminal png
		set output "grafici/opt_${name}_jitter_cvorovi_s20.png"
		set xlabel "Broj čvorova"
		set autoscale
		set ylabel "Jitter (s)"
		set grid
		set style data linespoints
		set key outside;
		set key right center;
		plot "${opt}/nodes/s20/prot_0_jitter.txt" using 1:2 title "AODV" lw 2 linecolor rgb "red", "${opt}/nodes/s20/prot_1_jitter.txt" using 1:2 title "DSDV" lw 2 linecolor rgb "green", "${opt}/nodes/s20/prot_2_jitter.txt" using 1:2 title "OLSR" lw 2 linecolor rgb "orange", "${opt}/nodes/s20/prot_3_jitter.txt" using 1:2 title "DSR" lw 2 linecolor rgb "blue"
	EOFMarker

#2e
	gnuplot -persist <<-EOFMarker
		set terminal png
		set output "grafici/opt_${name}_throughput_cvorovi_s20.png"
		set xlabel "Broj čvorova"
		set autoscale
		set ylabel "Throughput (Kbps)"
		set grid
		set style data linespoints
		set key outside;
		set key right center;
		plot "${opt}/nodes/s20/prot_0_throughput.txt" using 1:2 title "AODV" lw 2 linecolor rgb "red", "${opt}/nodes/s20/prot_1_throughput.txt" using 1:2 title "DSDV" lw 2 linecolor rgb "green", "${opt}/nodes/s20/prot_2_throughput.txt" using 1:2 title "OLSR" lw 2 linecolor rgb "orange", "${opt}/nodes/s20/prot_3_throughput.txt" using 1:2 title "DSR" lw 2 linecolor rgb "blue"
	EOFMarker
	
#3a
	
	gnuplot -persist <<-EOFMarker
		set terminal png
		set output "grafici/opt_${name}_pdr_brzine_n10.png"
		set xlabel "Brzina čvorova (m/s)"
		set autoscale
		set ylabel "Packet Delivery Ratio"
		set grid
		set style data linespoints
		set key outside;
		set key right center;
		plot "${opt}/speed/n10/prot_0_pdr.txt" using 1:2 title "AODV" lw 2 linecolor rgb "red", "${opt}/speed/n10/prot_1_pdr.txt" using 1:2 title "DSDV" lw 2 linecolor rgb "green", "${opt}/speed/n10/prot_2_pdr.txt" using 1:2 title "OLSR" lw 2 linecolor rgb "orange", "${opt}/speed/n10/prot_3_pdr.txt" using 1:2 title "DSR" lw 2 linecolor rgb "blue"
	EOFMarker
#3b
	gnuplot -persist <<-EOFMarker
		set terminal png
		set output "grafici/opt_${name}_delay_brzine_n10.png"
		set xlabel "Brzina čvorova (m/s)"
		set autoscale
		set ylabel "Kašnjenje (s)"
		set grid
		set style data linespoints
		set key outside;
		set key right center;
		plot "${opt}/speed/n10/prot_0_delay.txt" using 1:2 title "AODV" lw 2 linecolor rgb "red", "${opt}/speed/n10/prot_1_delay.txt" using 1:2 title "DSDV" lw 2 linecolor rgb "green", "${opt}/speed/n10/prot_2_delay.txt" using 1:2 title "OLSR" lw 2 linecolor rgb "orange", "${opt}/speed/n10/prot_3_delay.txt" using 1:2 title "DSR" lw 2 linecolor rgb "blue"
	EOFMarker
#3c
	gnuplot -persist <<-EOFMarker
		set terminal png
		set output "grafici/opt_${name}_overhead_brzine_n10.png"
		set xlabel "Brzina čvorova (m/s)"
		set autoscale
		set ylabel "Normalizirano opterećenje usmjeravanja"
		set grid
		set style data linespoints
		set key outside;
		set key right center;
		plot "${opt}/speed/n10/prot_0_overhead.txt" using 1:2 title "AODV" lw 2 linecolor rgb "red", "${opt}/speed/n10/prot_1_overhead.txt" using 1:2 title "DSDV" lw 2 linecolor rgb "green", "${opt}/speed/n10/prot_2_overhead.txt" using 1:2 title "OLSR" lw 2 linecolor rgb "orange", "${opt}/speed/n10/prot_3_overhead.txt" using 1:2 title "DSR" lw 2 linecolor rgb "blue"
	EOFMarker
	
#3d
		gnuplot -persist <<-EOFMarker
		set terminal png
		set output "grafici/opt_${name}_jitter_brzine_n10.png"
		set xlabel "Brzina čvorova (m/s)"
		set autoscale
		set ylabel "Jitter (s)"
		set grid
		set style data linespoints
		set key outside;
		set key right center;
		plot "${opt}/speed/n10/prot_0_jitter.txt" using 1:2 title "AODV" lw 2 linecolor rgb "red", "${opt}/speed/n10/prot_1_jitter.txt" using 1:2 title "DSDV" lw 2 linecolor rgb "green", "${opt}/speed/n10/prot_2_jitter.txt" using 1:2 title "OLSR" lw 2 linecolor rgb "orange", "${opt}/speed/n10/prot_3_jitter.txt" using 1:2 title "DSR" lw 2 linecolor rgb "blue"
	EOFMarker

#3e
	gnuplot -persist <<-EOFMarker
		set terminal png
		set output "grafici/opt_${name}_throughput_brzine_n10.png"
		set xlabel "Brzina čvorova (m/s)"
		set autoscale
		set ylabel "Throughput (Kbps)"
		set grid
		set style data linespoints
		set key outside;
		set key right center;
		plot "${opt}/speed/n10/prot_0_throughput.txt" using 1:2 title "AODV" lw 2 linecolor rgb "red", "${opt}/speed/n10/prot_1_throughput.txt" using 1:2 title "DSDV" lw 2 linecolor rgb "green", "${opt}/speed/n10/prot_2_throughput.txt" using 1:2 title "OLSR" lw 2 linecolor rgb "orange", "${opt}/speed/n10/prot_3_throughput.txt" using 1:2 title "DSR" lw 2 linecolor rgb "blue"
	EOFMarker
	
#4a
	gnuplot -persist <<-EOFMarker
		set terminal png
		set output "grafici/opt_${name}_pdr_brzine_n50.png"
		set xlabel "Brzina čvorova (m/s)"
		set autoscale
		set ylabel "Packet Delivery Ratio"
		set grid
		set style data linespoints
		set key outside;
		set key right center;
		plot "${opt}/speed/n50/prot_0_pdr.txt" using 1:2 title "AODV" lw 2 linecolor rgb "red", "${opt}/speed/n50/prot_1_pdr.txt" using 1:2 title "DSDV" lw 2 linecolor rgb "green", "${opt}/speed/n50/prot_2_pdr.txt" using 1:2 title "OLSR" lw 2 linecolor rgb "orange", "${opt}/speed/n50/prot_3_pdr.txt" using 1:2 title "DSR" lw 2 linecolor rgb "blue"
	EOFMarker
#4b
	gnuplot -persist <<-EOFMarker
		set terminal png
		set output "grafici/opt_${name}_delay_brzine_n50.png"
		set xlabel "Brzina čvorova (m/s)"
		set autoscale
		set ylabel "Kašnjenje (s)"
		set grid
		set style data linespoints
		set key outside;
		set key right center;
		plot "${opt}/speed/n50/prot_0_delay.txt" using 1:2 title "AODV" lw 2 linecolor rgb "red", "${opt}/speed/n50/prot_1_delay.txt" using 1:2 title "DSDV" lw 2 linecolor rgb "green", "${opt}/speed/n50/prot_2_delay.txt" using 1:2 title "OLSR" lw 2 linecolor rgb "orange", "${opt}/speed/n50/prot_3_delay.txt" using 1:2 title "DSR" lw 2 linecolor rgb "blue"
	EOFMarker
#4c
	gnuplot -persist <<-EOFMarker
		set terminal png
		set output "grafici/opt_${name}_overhead_brzine_n50.png"
		set xlabel "Brzina čvorova (m/s)"
		set autoscale
		set ylabel "Normalizirano opterećenje usmjeravanja"
		set grid
		set style data linespoints
		set key outside;
		set key right center;
		plot "${opt}/speed/n50/prot_0_overhead.txt" using 1:2 title "AODV" lw 2 linecolor rgb "red", "${opt}/speed/n50/prot_1_overhead.txt" using 1:2 title "DSDV" lw 2 linecolor rgb "green", "${opt}/speed/n50/prot_2_overhead.txt" using 1:2 title "OLSR" lw 2 linecolor rgb "orange", "${opt}/speed/n50/prot_3_overhead.txt" using 1:2 title "DSR" lw 2 linecolor rgb "blue"
	EOFMarker
	
#4d
	gnuplot -persist <<-EOFMarker
		set terminal png
		set output "grafici/opt_${name}_jitter_brzine_n50.png"
		set xlabel "Brzina čvorova (m/s)"
		set autoscale
		set ylabel "Jitter (s)"
		set grid
		set style data linespoints
		set key outside;
		set key right center;
		plot "${opt}/speed/n50/prot_0_jitter.txt" using 1:2 title "AODV" lw 2 linecolor rgb "red", "${opt}/speed/n50/prot_1_jitter.txt" using 1:2 title "DSDV" lw 2 linecolor rgb "green", "${opt}/speed/n50/prot_2_jitter.txt" using 1:2 title "OLSR" lw 2 linecolor rgb "orange", "${opt}/speed/n50/prot_3_jitter.txt" using 1:2 title "DSR" lw 2 linecolor rgb "blue"
	EOFMarker

#4e
	gnuplot -persist <<-EOFMarker
		set terminal png
		set output "grafici/opt_${name}_throughput_brzine_n50.png"
		set xlabel "Brzina čvorova (m/s)"
		set autoscale
		set ylabel "Throughput (Kbps)"
		set grid
		set style data linespoints
		set key outside;
		set key right center;
		plot "${opt}/speed/n50/prot_0_throughput.txt" using 1:2 title "AODV" lw 2 linecolor rgb "red", "${opt}/speed/n50/prot_1_throughput.txt" using 1:2 title "DSDV" lw 2 linecolor rgb "green", "${opt}/speed/n50/prot_2_throughput.txt" using 1:2 title "OLSR" lw 2 linecolor rgb "orange", "${opt}/speed/n50/prot_3_throughput.txt" using 1:2 title "DSR" lw 2 linecolor rgb "blue"
	EOFMarker
done  
