LOG_FILE="$HOME/devops/day6/server-health/health.log"
echo "Health check started $(date)" > "$LOG_FILE"
check_port(){
	echo "======= PORT 22 ========"	
	if ss -tln | grep -q ':22'; then
		echo "Port 22: LISTENING"
	else
		echo "Port 22: NOT LISTENING"
	fi
}
check_disk(){
	echo "===== DISK ====="
	df -h /
}

check_momory(){
	echo "===== MEMORY ====="
	free -h
}

check_ssh(){
	echo "===== SSH ======="
	if systemctl is-active --quiet ssh; then
		echo "SSH: OK"
	else
		echo "SSH: FAILED"
	fi
}
echo "Hostname $(hostname)"
echo "Current User $(whoami)"
echo "Current date/time $(date)" 
check_disk
check_memory
check_ssh
check_port
echo "Health Check Completed $(date)" >> "$LOG_FILE"
