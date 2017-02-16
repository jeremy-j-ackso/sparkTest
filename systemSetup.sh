## This is for the single-node configuration.

## Add R-Project repository info so that you can get the most recent version of R.
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9
sudo echo "deb https://cran.r-project.org/bin/linux/ubuntu xenial/" >> /etc/apt/sources.list

## Either get spark online or from local development directory.
#wget http://d3kbcqa49mib13.cloudfront.net/spark-2.0.0-bin-hadoop2.7.tgz
cp /vagrant/spark-2.0.0-bin-hadoop2.7.tgz ./

## Either get RStudio Server online or from local development directory.
#wget https://download2.rstudio.org/rstudio-server-0.99.903-amd64.deb
cp /vagrant/rstudio-server-1.0.136-amd64.deb ./

## Install required software.
apt-get -y update
apt-get -y install openjdk-8-jdk r-base r-base-dev build-essential gdebi-core libcurl4-openssl-dev

## Configure firewall.
#ufw allow 8787 #RStudio
#ufw allow 22 #ssh
#ufw enable

## Unpack Spark to it's install directory.
tar -xzf spark-2.0.0-bin-hadoop2.7.tgz -C /opt

## Add Spark to the system path.
echo "SPARK_HOME=\"/opt/spark-2.0.0-bin-hadoop2.7\"" > /etc/profile.d/paths.sh
echo "PATH=\"\$PATH:\$SPARK_HOME/bin\"" >> /etc/profile.d/paths.sh
echo "export PATH" >> /etc/profile.d/paths.sh

## Install RStudio Server.
gdebi -n rstudio-server-1.0.136-amd64.deb 

## Add Spark locations to the R path so that R can find SparkR. Then restart RStudio so that these take effect.
echo ".libPaths('/opt/spark-2.0.0-bin-hadoop2.7/R/lib')" >> /etc/R/Rprofile.site
echo "if (nchar(Sys.getenv(\"SPARK_HOME\")) < 1) Sys.setenv(SPARK_HOME = \"/opt/spark-2.0.0-bin-hadoop2.7\")" >> /etc/R/Rprofile.site
rstudio-server restart
