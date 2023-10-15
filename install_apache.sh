#!/bin/bash
        sudo apt update -y
        sudo apt install apache2 -y
        sudo systemctl start apache2
        echo "<h1>Created using Terraform</h1><p>The page was created by the user data</p>" | sudo tee /var/www/html/index.html