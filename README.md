
# Server Performance Stats Script

**Project URL:** [https://github.com/shuvo-halder/Performance-Stats](https://github.com/shuvo-halder/Performance-Stats)

A simple Bash script that displays real-time server performance and system statistics in a clean, readable format. Useful for quick health checks on Linux servers.

## Features

The script provides the following information:

* **OS Version**

  * Displays the operating system name and version.
* **Uptime & Load Average**

  * Shows how long the system has been running and current load averages.
* **Logged-in Users**

  * Lists all users currently logged into the system.
* **CPU Usage**

  * Displays total CPU usage percentage.
* **Memory Usage**

  * Shows total, used, and free memory with percentage usage.
* **Disk Usage**

  * Displays total, used, and free disk space across all mounted filesystems.
* **Top Processes**

  * Top 5 processes by:

    * CPU usage
    * Memory usage
* **Failed Login Attempts**

  * Counts failed SSH/login attempts from system authentication logs.

## Requirements

* Linux-based operating system
* Bash shell
* Common system utilities:

  * `uptime`
  * `top`
  * `free`
  * `df`
  * `ps`
  * `who`
  * `grep`, `awk`, `wc`

> The script checks both `/var/log/auth.log` (Debian/Ubuntu) and `/var/log/secure` (RHEL/CentOS) for failed login attempts.

## Usage

1. Clone the repository:

   ```bash
   git clone https://github.com/shuvo-halder/Performance-Stats.git
   cd Performance-Stats
   ```

2. Make the script executable:

   ```bash
   chmod +x server-stats.sh
   ```

3. Run the script:

   ```bash
   ./server-stats.sh
   ```

## Example Output

```
=======================================
        SERVER PERFORMANCE STATS
=======================================

--- OS Version ---
Ubuntu 22.04.3 LTS

--- Uptime & Load Average ---
 10:32:18 up 5 days,  2:14,  1 user,  load average: 0.12, 0.08, 0.05

--- CPU Usage ---
CPU Usage: 14.3%

--- Memory Usage ---
Used: 2048MB / 8192MB (25.00%)
Free: 6144MB

--- Disk Usage ---
Used: 40G / 100G (40%)
Free: 60G
```

## Notes

* Run as a normal user for general statistics.
* Access to authentication logs may require elevated permissions.
* Designed for quick diagnostics rather than long-term monitoring.

## License

This project is open-source and free to use, modify, and distribute.

