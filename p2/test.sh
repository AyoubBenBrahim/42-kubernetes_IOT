#!/bin/sh

#output=$(kubectl get pods --namespace default | awk '{ print $3 }' | awk 'NR!=1' | grep Running | wc -l)

while (true)
    do
        output=$(kubectl get pods --namespace default | awk '{ print $3 }' | awk 'NR!=1' | grep Running | wc -l)
         
     if [ $output == "1" ]; then
              echo -e "\033[0;32m Pod1 is Running .....\033[0m"
     
     elif [ $output == "2" ]; then
            echo -e "\033[0;32m Pod2 is Running .....\033[0m"
     
     elif [ $output == "3" ]; then
            echo -e "\033[0;32m Pod3 is Running .....\033[0m"
     
     elif [ $output == "4" ]; then
            echo -e "\033[0;32m Pod4 is Running .....\033[0m"
     
     elif [ $output == "5" ]; then
            echo -e "\033[0;32m All Pods are Ready and  Running .....\033[0m"
        sleep 1
        exit 0
    
     else 
        echo -e "\033[0;32m Waiting for Pods to get Ready .....\033[0m"
     fi
    
    done


