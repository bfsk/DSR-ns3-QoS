#!/bin/sh
find output_data -type f -iname "*.txt" -exec rm -f {} \; 
for opt in 0.1 0.5 1
do
        for protocol in 0 1 2 3
	do
		for nodes in  5 10 15 20 25 30 35 40 45 50
		do
			printf "opterecenje = ${opt}  protokol = ${protocol} nodes = ${nodes} nodeSpeed = 2\n"
			./waf --run "scratch/tema5 --numberOfNodes=${nodes} --routingProtocolType=${protocol} --nodeSpeed=2.0 --proc=${opt} --dataFileName=output_data/${opt}/nodes/s2/prot_${protocol} --xAxis=${nodes}" > /dev/null
			printf "opterecenje = ${opt}  protokol = ${protocol} nodes = ${nodes} nodeSpeed = 20\n"
			./waf --run "scratch/tema5 --numberOfNodes=${nodes} --routingProtocolType=${protocol} --nodeSpeed=20.0 --proc=${opt} --dataFileName=output_data/${opt}/nodes/s20/prot_${protocol} --xAxis=${nodes}" > /dev/null
		done
		for speed in 2 4 6 8 10 12 14 16 18 20
		do
			printf "opterecenje = ${opt}  protokol = ${protocol} speed = ${speed} nodes = 10\n"
			./waf --run "scratch/tema5 --numberOfNodes=10 --routingProtocolType=${protocol} --nodeSpeed=${speed} --proc=${opt} --dataFileName=output_data/${opt}/speed/n10/prot_${protocol} --xAxis=${speed}" > /dev/null
			printf "opterecenje = ${opt}  protokol = ${protocol} speed = ${speed} nodes = 50\n"
			./waf --run "scratch/tema5 --numberOfNodes=50 --routingProtocolType=${protocol} --nodeSpeed=${speed} --proc=${opt} --dataFileName=output_data/${opt}/speed/n50/prot_${protocol} --xAxis=${speed}" > /dev/null
		done
	done
done  
