## Setup hostname and make it immediately active.
hostname follower
echo "follower" > /etc/hostname

## Switch the commenting of these two lines to download a fresh version of spark instead of using one in the deveopment directory.
#wget http://d3kbcqa49mib13.cloudfront.net/spark-2.0.0-bin-hadoop2.7.tgz
cp /vagrant/spark-2.0.0-bin-hadoop2.7.tgz ./

## Installs software from repos.
apt-get -qy update
apt-get -yq install openjdk-8-jdk build-essential 

## Opens up firewall ports. This is probably unsecure. Should have a network admin advise before putting into production.
#ufw allow from 192.168.1.0/24
#ufw allow 22 #ssh
#ufw allow 6060 #Not sure.
#ufw allow 8081 #Worker Web UI.
#ufw --force enable

## Unpacks spark to it's installed location.
tar -xzf spark-2.0.0-bin-hadoop2.7.tgz -C /opt

## Adds Spark locations to the path.
echo "SPARK_HOME=\"/opt/spark-2.0.0-bin-hadoop2.7\"" > /etc/profile.d/paths.sh
echo "PATH=\"\$PATH:\$SPARK_HOME/bin:\$SPARK_HOME/sbin\"" >> /etc/profile.d/paths.sh
echo "export PATH" >> /etc/profile.d/paths.sh

## Bring in the spark-env.sh file
#cp /vagrant/spark-env.sh $SPARK_HOME/conf/spark-env.sh

## There should also be more security around users here.
chown -R vagrant:vagrant /opt/spark-2.0.0-bin-hadoop2.7

## Change this to reflect all of the IP addresses for every node in the cluster.
echo "10.2.0.15 master" >> /etc/hosts
echo "10.2.0.16 follower" >> /etc/hosts

## Set this machine to always be the master.
#echo "SPARK_MASTER_HOST = master" > /opt/spark-2.0.0-bin-hadoop2.7/conf/spark-env.sh
#echo "SPARK_LOCAL_IP = 10.0.2.16" > /opt/spark-2.0.0-bin-hadoop2.7/conf/spark-env.sh

## Grab the public ssh key from the place.
#echo /vagrant/vagrancy_rsa.pub >> /home/vagrant/.ssh/authorized_keys
