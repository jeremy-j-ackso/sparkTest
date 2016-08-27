## Setup hostname and make it immediately active.
hostname master
echo "master" > /etc/hostname

## This is required info to get the most recent version of R.
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9
sudo echo "deb https://cran.r-project.org/bin/linux/ubuntu trusty/" >> /etc/apt/sources.list

## Switch the commenting of these two lines to download a fresh version of spark instead of using one already downloaded to the development directory.
#wget http://d3kbcqa49mib13.cloudfront.net/spark-2.0.0-bin-hadoop2.7.tgz
cp /vagrant/spark-2.0.0-bin-hadoop2.7.tgz ./

## This gets the RStudio package. The first one downloads it for installation to production. The second gets it from the local vagrant directory for development scenarios where waiting around for a download might not be efficient.
#wget https://download2.rstudio.org/rstudio-server-0.99.903-amd64.deb
cp /vagrant/rstudio-server-0.99.903-amd64.deb ./

## Installs software from repos.
apt-get -y update
apt-get -y install openjdk-7-jdk r-base r-base-dev build-essential gdebi-core

## Configures firewall. Probably not the most secure way to do this. Need to talk to a network admin about it.
ufw allow 192.168.1.0/24
ufw allow 8787 #Rstudio
ufw allow 22 #SSH
ufw allow 8080 #The Spark cluster master web ui.
ufw allow 7070 #Not sure
ufw allow 7077 #Submit jobs to the cluster or join the cluster.
ufw allow 6060 #Not sure
ufw --force enable

## Unpack spark to it's installed location.
tar -xzf spark-2.0.0-bin-hadoop2.7.tgz -C /opt

## Adds Spark locations to the path.
echo "SPARK_HOME=\"/opt/spark-2.0.0-bin-hadoop2.7\"" > /etc/profile.d/paths.sh
echo "PATH=\"\$PATH:\$SPARK_HOME/bin:\$SPARK_HOME/sbin\"" >> /etc/profile.d/paths.sh
echo "export PATH" >> /etc/profile.d/paths.sh

## Installs RStudio Server.
gdebi -n rstudio-server-0.99.903-amd64.deb 

## Cofigures R so that it can find the SparkR library.
echo ".libPaths('/opt/spark-2.0.0-bin-hadoop2.7/R/lib')" >> /etc/R/Rprofile.site
echo "if (nchar(Sys.getenv(\"SPARK_HOME\")) < 1) Sys.setenv(SPARK_HOME = \"/opt/spark-2.0.0-bin-hadoop2.7\")" >> /etc/R/Rprofile.site

## Restart RStudio so that the previous changes can take affect.
rstudio-server restart

## There should also be more security around users here.
chown vagrant:vagrant /opt/spark-2.0.0-bin-hadoop2.7

## Change this to reflect all of the IP addresses for every node in the cluster.
echo "192.168.1.100 master" >> /etc/hosts
echo " 192.168.1.101 follower" >> /etc/hosts
