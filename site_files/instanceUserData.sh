#!/bin/bash
yum -y update
yum -y install httpd
sudo yum install git -y
git clone https://github.com/PAYNEA03/AWEXTerraformLab.git
cp /AWEXTerraformLab/site_files/index.html /var/www/html/
service httpd start
chkconfig httpd on