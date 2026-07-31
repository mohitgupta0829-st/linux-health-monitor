# 🐧 Linux Health Monitor & Auto Backup

A Bash-based Linux system monitoring and automation tool that helps monitor system health, verify critical services, create timestamped backups, and generate execution logs.

Designed as a practical DevOps/Linux administration project to automate common maintenance tasks.

---

## ✨ Features

- 📊 Monitor Disk Usage
- 🧠 Monitor Memory Usage
- 🔍 Check Critical Services
- Docker
- SSH
- Nginx
- 📦 Create Timestamped Backups
- 📝 Generate Execution Logs
- ⚠️ Configurable Warning Thresholds
- 🖥️ Interactive Menu
- ⏰ Cron-Compatible Automation (`--all` mode)

---

## 🛠️ Tech Stack

- Bash
- Linux (Ubuntu)
- Cron
- tar
- gzip
- systemctl
- Shell Utilities

---

## 📂 Project Structure

```
linux-health-monitor/
│
├── monitor.sh              # Main Bash script
├── backup/                 # Backup storage
├── system_report.log       # Execution logs
├── README.md
```

---

## 🚀 How It Works

The script provides two execution modes.

### Interactive Mode

Displays a menu where you can choose individual operations.

```
./monitor.sh
```

Example:

```
1. Check Disk Usage
2. Check Memory Usage
3. Check Services
4. Create Backup
5. Run Everything
6. Exit
```

---

### Automatic Mode

Run every task sequentially.

```
./monitor.sh --all
```

Perfect for Cron Jobs.

---

## 📊 Example Output

```
----- Run at Fri Jul 31 06:18:32 PM IST -----

Filesystem      Size Used Avail Use%
/dev/nvme0n1p2 233G 53G 169G 24%

Memory
Used: 2.9Gi
Available: 838Mi

docker : NOT RUNNING
ssh    : NOT RUNNING
nginx  : NOT RUNNING

Backup successful:
backup_2026-07-31.tar.gz
```

---

## 📝 Logging

Every execution is recorded inside:

```
system_report.log
```

The log includes:

- Execution Timestamp
- Disk Usage
- Memory Usage
- Service Status
- Backup Status

This makes troubleshooting and auditing much easier.

---

## 📦 Backup

The backup module automatically creates compressed archives using `tar`.

Example:

```
backup_2026-07-31.tar.gz
```

Each backup includes a timestamp to avoid overwriting previous backups.

---

## ⏰ Cron Automation

Run the script automatically every day.

Example:

```bash
0 9 * * * /path/to/monitor.sh --all
```

This executes the full monitoring workflow every day at **9:00 AM**.

---

## 📚 What I Learned

Through this project I gained practical experience with:

- Bash scripting
- Linux system administration
- Process & service monitoring
- Cron job automation
- Logging and troubleshooting
- File compression and backups
- Shell scripting best practices
- Error handling in Bash

---

## 🔮 Future Improvements

- Email Notifications
- Slack/Discord Alerts
- Prometheus Metrics Exporter
- Grafana Dashboard Integration
- Log Rotation
- Config File Support
- Docker Container Monitoring
- Kubernetes Node Monitoring

---

## 👨‍💻 Author

**Mohit Gupta**

- GitHub: https://github.com/mohitgupta0829-st
- LinkedIn: https://www.linkedin.com/in/mohitgupta-dev28

---

## ⭐ Support

If you found this project useful, consider giving it a ⭐ on GitHub.