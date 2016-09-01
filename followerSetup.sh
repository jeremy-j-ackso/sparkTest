## Setup hostname and make it immediately active.
hostname follower
echo "follower" > /etc/hostname

## Switch the commenting of these two lines to download a fresh version of spark instead of using one in the deveopment directory.
#wget http://d3kbcqa49mib13.cloudfront.net/spark-2.0.0-bin-hadoop2.7.tgz
cp /vagrant/spark-2.0.0-bin-hadoop2.7.tgz ./

## Installs software from repos.
apt-get -y update
apt-get -y install openjdk-7-jdk build-essential 

## Opens up firewall ports. This is probably unsecure. Should have a network admin advise before putting into production.
ufw allow from 192.168.1.0/24
ufw allow 22 #ssh
ufw allow 6060 #Not sure.
ufw allow 8081 #Worker Web UI.
ufw --force enable

## Unpacks spark to it's installed location.
tar -xzf spark-2.0.0-bin-hadoop2.7.tgz -C /opt

## Adds Spark locations to the path.
echo "SPARK_HOME=\"/opt/spark-2.0.0-bin-hadoop2.7\"" > /etc/profile.d/paths.sh
echo "PATH=\"\$PATH:\$SPARK_HOME/bin:\$SPARK_HOME/sbin\"" >> /etc/profile.d/paths.sh
echo "export PATH" >> /etc/profile.d/paths.sh

## There should also be more security around users here.
chown vagrant:vagrant /opt/spark-2.0.0-bin-hadoop2.7

## Change this to reflect all of the IP addresses for every node in the cluster.
echo "192.168.1.100 master" >> /etc/hosts
echo "192.168.1.101 follower" >> /etc/hosts
