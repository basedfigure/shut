#!/bin/bash

echo "; Installing server ;"

sudo apt update
sudo apt install -y openssh-server

sudo systemctl enable ssh
sudo systemctl start ssh

mkdir -p ~/sh

cat << 'EOF' > /sh/ssh_inst.sh
#!/bin/bash
echo "Hi-fu!"
echo "Hostname:  $(hostname)"
echo "Data:  $(date)"
EOF

chmod +x ~/sh/ssh_inst.sh

echo "; Server install finished "
echo "* scripts are in dir:  ~/sh ;;"