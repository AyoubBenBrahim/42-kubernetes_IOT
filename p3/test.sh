

  while (true)
        do
            output=$(sudo kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}") > /dev/null 2>&1
            len=${#output}
            
            if [ $len -eq 24 ]; then 
                echo "agroCD password is: "
                sudo kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
                exit 0
            fi

            echo "\033[0;31m waiting for argoCD to get ready .....\033[0m"
            sleep 4

        done








#  open -a "Firefox" https://192.168.42.112:80




