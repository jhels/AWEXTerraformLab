#!/bin/bash
yum -y update
yum -y install httpd
sudo yum install git -y
git clone git clone https://github.com/PAYNEA03/nestedJenkins1.git
cp /AWEXTerraformLab/site_files/index.html /var/www/html/
service httpd start
chkconfig httpd on