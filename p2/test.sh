#!/bin/sh

   while (true)
        do
            output=$(curl -s -o /dev/null -w '%{http_code}' 192.168.42.110)
             
         if [ $output == "200" ]; then
            echo -e "\033[0;32m HTTP request was successful .....\033[0m"
            exit 0
         
         else
            echo -e "\033[0;31m HTTP server fails to deliver the page .....\033[0m"
            sleep 2
         fi
        
        done