#!/bin/bash


echo "======================================="
echo "        SERVER PERFORMANCE STATS        "
echo "======================================="

# 🔹 OS version
echo -e "\n--- OS Version ---"
if [ -f /etc/os-release ]; then
    . /etc/os-release
    echo "$PRETTY_NAME"
else
    uname -a
fi

# 🔹 Uptime & Load Average
echo -e "\n--- Uptime & Load Average ---"
uptime

# 🔹 Logged in users
echo -e "\n--- Logged in Users ---"
who

# 🔹 Total CPU usage
echo -e "\n--- Total CPU Usage ---"
cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
echo "CPU Usage: $cpu_usage%"

# 🔹 Total memory usage
echo -e "\n--- Memory Usage ---"
free -h
mem_total=$(free -m | awk '/Mem:/ {print $2}')
mem_used=$(free -m | awk '/Mem:/ {print $3}')
mem_free=$(free -m | awk '/Mem:/ {print $4}')
mem_percent=$(free | awk '/Mem:/ {printf("%.2f"), $3/$2*100}')
echo "Used: ${mem_used}MB / ${mem_total}MB (${mem_percent}%)"
echo "Free: ${mem_free}MB"

# 🔹 Total disk usage
echo -e "\n--- Disk Usage ---"
df -h --total | grep total

disk_total=$(df --total | awk '/total/ {print $2}')
disk_used=$(df --total | awk '/total/ {print $3}')
disk_free=$(df --total | awk '/total/ {print $4}')
disk_percent=$(df --total | awk '/total/ {print $5}')
echo "Used: $disk_used / $disk_total ($disk_percent)"
echo "Free: $disk_free"

# 🔹 Top 5 processes by CPU usage
echo -e "\n--- Top 5 Processes by CPU ---"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6

# 🔹 Top 5 processes by Memory usage
echo -e "\n--- Top 5 Processes by Memory ---"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6

# 🔹 Stretch goal: Failed login attempts
echo -e "\n--- Failed Login Attempts ---"
if [ -f /var/log/auth.log ]; then
    grep "Failed password" /var/log/auth.log | wc -l
elif [ -f /var/log/secure ]; then
    grep "Failed password" /var/log/secure | wc -l
else
    echo "No auth log found."
fi

echo "======================================="
echo "        Report End                     "
echo "======================================="
