PASSWORD=$(date | md5sum | awk '{print $1}')
SCRIPT_PARENT=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

echo "Installing Node.js v12"
sleep 2

# install node.js 12
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
source ~/.bashrc
nvm install 12

echo "Creating FTP user \"ftp-user\" with password \"$PASSWORD\""
sleep 2

# create an ftp user
useradd ftp-user
echo $PASSWORD | passwd ftp-user --stdin

# install ftpd
echo "Installing vsftpd and JQ"
sleep 2
dnf -y install vsftpd jq
systemctl enable vsftpd

# install firewalld
echo "Setup firewall rules for FTP"
sleep 2
yum -y install firewalld
systemctl start firewalld
firewall-cmd --add-service=ftp --perm
firewall-cmd --add-port=40000-40001/tcp --perm
firewall-cmd --reload

# start the ftp server
echo "Starting FTP service"
sleep 2
setsebool -P ftpd_use_passive_mode on
systemctl start vsftpd

# deploy the generator
echo "Deploying data generator"
sleep 2
npm i forever -g
cd "$SCRIPT_PARENT/data-generator/"
npm install
forever start -c "npm run start" ./

echo "\nConnect via ftp://$(curl https://whatsmyip.dev/api/ip | jq -r '.addr')"
echo "Use the username/password ftp-user/$PASSWORD"
