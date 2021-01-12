import sys
import telnetlib
import subprocess
import ftplib

router_ip_address = "192.168.31.1"
router_ip_address = input("Router IP address [press enter for using the default {}]: ".format(router_ip_address)) or router_ip_address

try:
	tn = telnetlib.Telnet(router_ip_address,timeout=5)
except:
	print ("telnet server not found")
	sys.exit(1)
tn.read_until(b"login:")
tn.write(b"root\n")
tn.read_until(b"root@XiaoQiang:~#")
print ("Creating complete flash backup")
tn.write(b"dd if=/dev/mtd0 of=/tmp/flash-backup.bin\n")
tn.read_until(b"root@XiaoQiang:~#")
tn.write(b"exit\n")
print ("Done")

ftp=ftplib.FTP(router_ip_address)
file=open('data/flash-backup.bin', 'wb')
print ("Downloading backup")
ftp.retrbinary('RETR /tmp/flash-backup.bin', file.write)
file.close()
ftp.quit()
print ("Done")

tn = telnetlib.Telnet(router_ip_address)
tn.read_until(b"login:")
tn.write(b"root\n")
tn.read_until(b"root@XiaoQiang:~#")
print ("Removing tmp")
tn.write(b"rm /tmp/flash-backup.bin\n")
tn.read_until(b"root@XiaoQiang:~#")
tn.write(b"exit\n")
print ("Done")
