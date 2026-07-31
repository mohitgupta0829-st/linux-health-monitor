#!/bin/bash
set -euo pipefail

# ============================================
# System Health Monitor & Auto-Backup Tool
# Structure/skeleton only — fill in the TODOs
# ============================================

LOG_FILE="system_report.log"
SERVICES=("docker" "ssh" "nginx")   # edit this list to services you actually have

# ---------- FUNCTIONS ----------
# Each function does ONE job. The menu below just calls these.

check_disk() {
    echo "Checking disk usage..."
    usg=$(df -h)
    usage=$(df -h / | awk 'NR==2 {print $5}' | tr -d '%')
    if [ "$usage" -gt 80 ]; then
	    # Walk through that: df -h / → info for root partition only → awk 'NR==2 {print $5}' 
	    # grabs the 5th column ("Use%") from the second line → tr -d '%' 
	    # strips the % sign so you're left with a plain number like 62.
	    echo -e "\n $usg \n WARNING: disk usage is at ${usage}%, which is above 80%" >> "$LOG_FILE"
    else
	    echo -e " \n $usg \n every thing nice " >> "$LOG_FILE"
    fi
    # TODO: run `df -h`, capture the % used for your main partition
    # TODO: if usage > 80, print a WARNING
    # TODO: append the result to $LOG_FILE with a timestamp
}

check_memory() {
    echo "Checking memory usage..."
    free -h >> "$LOG_FILE"
    # TODO: run `free -h`
    # TODO: append result to $LOG_FILE
}

check_services() {
    echo "Checking services..."
    for service in "${SERVICES[@]}"; do
        if systemctl is-active --quiet "$service"; then
            echo "$service: RUNNING" >> "$LOG_FILE"
        else
            echo "$service: NOT RUNNING" >> "$LOG_FILE"
        fi
    done
    # TODO: loop through SERVICES array
    # TODO: for each one, check if it's active (systemctl is-active <service>)
    # TODO: print/log "RUNNING" or "NOT RUNNING" per service
}

backup_dir() {
    echo "Starting backup..."
    read -p "Enter the folder path to backup: " folder_path

    if [ ! -d "$folder_path" ]; then
        echo "Folder does not exist: $folder_path" >> "$LOG_FILE"
        return
    fi

    backup_filename="backup_$(date +%F).tar.gz"
    tar -czf "$backup_filename" "$folder_path"
    tar_status=$?
    
    if [ "$tar_status" -eq 0 ]; then
        echo "Backup successful: $backup_filename" >> "$LOG_FILE"
    elif [ "$tar_status" -eq 1 ]; then
        echo "Backup completed with warnings (e.g. a file changed during backup): $backup_filename" >> "$LOG_FILE"
    else
        echo "Backup failed for folder: $folder_path" >> "$LOG_FILE"
    fi
    # TODO: read -p a folder path from the user
    # TODO: build a filename like backup_$(date +%F).tar.gz
    # TODO: run tar to compress the folder into that file
    # TODO: check $? after the tar command — log success or failure
}

run_all() {
    check_disk
    check_memory
    check_services
    backup_dir
    # TODO: just call check_disk, check_memory, check_services, backup_dir
    # this is what --all will trigger
    :
}

# ---------- MENU (interactive mode) ----------

show_menu() {
    echo ""
    echo "1) Check disk usage"
    echo "2) Check memory usage"
    echo "3) Check running services"
    echo "4) Backup a directory"
    echo "5) Run all checks"
    echo "6) Exit"
    read -p "Choose an option: " choice

    case "$choice" in
        1) check_disk ;;
        2) check_memory ;;
        3) check_services ;;
        4) backup_dir ;;
        5) run_all ;;
        6) echo "Bye"; exit 0 ;;
        *) echo "Invalid option" ;;
    esac
}
# ---------- ENTRY POINT ----------
# This decides: did the user pass an argument (like --all),
# or should we show the interactive menu?

if [ "$#" -eq 0 ]; then
    # No arguments given -> interactive mode
    echo "----- Run at $(date) -----" >> "$LOG_FILE"
    show_menu
else
    # Argument given -> non-interactive mode (for cron jobs etc.)
    echo "----- Run at $(date) -----" >> "$LOG_FILE"
    case "$1" in
        --all) run_all ;;
        *) echo "Unknown argument: $1" ;;
    esac
fi

echo "Done. Check $LOG_FILE for details."
