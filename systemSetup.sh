sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9
sudo echo "deb https://cran.r-project.org/bin/linux/ubuntu trusty/" >> /etc/apt/sources.list

#wget http://d3kbcqa49mib13.cloudfront.net/spark-2.0.0-bin-hadoop2.7.tgz
cp /vagrant/spark-2.0.0-bin-hadoop2.7.tgz ./

#wget https://download2.rstudio.org/rstudio-server-0.99.903-amd64.deb
cp /vagrant/rstudio-server-0.99.903-amd64.deb ./

apt-get -y update
apt-get -y install openjdk-7-jdk r-base r-base-dev build-essential gdebi-core

ufw allow 8787 
ufw allow 22
ufw allow 2222
ufw enable

tar -xzf spark-2.0.0-bin-hadoop2.7.tgz -C /opt

echo "SPARK_HOME=\"/opt/spark-2.0.0-bin-hadoop2.7\"" > /etc/profile.d/paths.sh
echo "PATH=\"\$PATH:\$SPARK_HOME/bin\"" >> /etc/profile.d/paths.sh
echo "export PATH" >> /etc/profile.d/paths.sh

gdebi -n rstudio-server-0.99.903-amd64.deb 

echo ".libPaths('/opt/spark-2.0.0-bin-hadoop2.7/R/lib')" >> /etc/R/Rprofile.site
echo "if (nchar(Sys.getenv(\"SPARK_HOME\")) < 1) Sys.setenv(SPARK_HOME = \"/opt/spark-2.0.0-bin-hadoop2.7\")" >> /etc/R/Rprofile.site
rstudio-server restart
