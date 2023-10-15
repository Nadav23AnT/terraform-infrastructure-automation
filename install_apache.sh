#!/bin/bash
        sudo apt update -y
        sudo apt install apache2 -y
        sudo systemctl start apache2
        echo "<h1>TerraForm Project - Deployed</h1><p>using user_data</p>" | sudo tee /var/www//html/index.html