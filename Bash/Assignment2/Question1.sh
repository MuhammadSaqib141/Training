#!/bin/bash


display_diskspace() {
   	echo "Disk Space: "
	df -h
	echo ""
}


display_cpu_processes() {
	echo "Top 10 Processes by CPU Usage:"
	ps -eo comm,%cpu --sort=-%cpu | head -n 11
	echo ""
}


display_mem_processes() {
	echo "Top 10 Processes by Memory Usage:"
	ps -eo comm,%mem --sort=-%mem | head -n 11
	echo ""
}


echo "Enter a number:"
echo "1 for Disk Space"
echo "2 for Top 10 CPU-consuming processes"
echo "3 for Top 10 Memory-consuming processes"
echo "write \"all\" to see above 3 options"
read option

if [[ $option == 1 ]]; then
        display_diskspace
elif [[ $option == 2 ]]; then
        display_cpu_processes
elif [[ $option == 3 ]]; then
	display_mem_processes
elif [[ "$option" == "all" ]]; then
	display_diskspace
	display_cpu_processes
	display_mem_processes
else
    echo "you selected Invalid option. Exiting the script"
fi
