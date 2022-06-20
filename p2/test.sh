#!/bin/sh

while (true)
    do
        output=$(kubectl get pods --namespace inception | awk '{ print $3 }' | awk 'NR!=1' | grep Running | wc -l)
         
        if [ $output == "1" ]; then
            echo -e "\033[0;32m Pod1 is Running .....\033[0m"
     
        elif [ $output == "2" ]; then
            echo -e "\033[0;32m Pod2 is Running .....\033[0m"
     
        elif [ $output == "3" ]; then
            echo -e "\033[0;32m Pod3 is Running .....\033[0m"
     
        elif [ $output == "4" ]; then
            echo -e "\033[0;32m Pod4 is Running .....\033[0m"
     
        elif [ $output == "5" ]; then
            echo -e "\033[0;32m \nAll Pods are Ready and  Running .....\n \033[0m"
            sleep 2
            # exit 0
            break

        else 
            echo -e "\033[0;31m Waiting for Pods to get Ready .....\033[0m"
            sleep 4
        fi
    
    done