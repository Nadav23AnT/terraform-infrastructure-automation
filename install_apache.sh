#!/bin/bash
        sudo apt update -y
        sudo apt install apache2 -y
        sudo systemctl start apache2
        sudo bash -c 'echo "<h1>created by TerraForm</h1><p>using user_data</p>" > /var/www/html/index.html'
