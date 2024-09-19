#!/bin/bash

display_diskspace() { echo "Disk Space: "; df -h; echo ""; }

display_cpu_processes() { echo "Top 10 Processes by CPU Usage:"; ps -eo comm,%cpu --sort=-%cpu | head -n 11; echo ""; }

display_mem_processes() { echo "Top 10 Processes by Memory Usage:"; ps -eo comm,%mem --sort=-%mem | head -n 11; echo ""; }

display_help() {
    echo "Help Menu:"
    echo "1: Show Disk Space"
    echo "2: Show Top 10 CPU-consuming processes"
    echo "3: Show Top 10 Memory-consuming processes"
    echo "all: Show all the above options"
    echo "help: Show this help menu"
    echo "exit: Exit the script"
    echo ""
}

# Check if --help is passed as an argument
if [[ "$1" == "--help" ]]; then
    display_help
    exit 0
fi

while true; do
    echo "Enter a number (or 'help' for options):"
    read option

    case $option in
        1)
            display_diskspace
            ;;
        2)
            display_cpu_processes
            ;;
        3)
            display_mem_processes
            ;;
        all)
            display_diskspace
            display_cpu_processes
            display_mem_processes
            ;;
        help)
            display_help
            ;;
        exit)
            echo "Exiting the script."
            break
            ;;
        *)
            echo "You selected an invalid option. Type 'help' for options."
            ;;
    esac
done
