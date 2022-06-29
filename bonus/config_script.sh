

echo "\n\n================================================================"
    echo  "\033[0;32m\t ********* Docker remove ********* 033[0m"
echo "================================================================\n\n"

    # sudo apt-get remove docker docker-engine docker.io containerd runc
    sudo apt-get purge docker-ce docker-ce-cli containerd.io docker-compose-plugin -y
    sudo apt autoremove -y

echo "\n\n================================================================"
    echo  "\033[0;32m\t ********* Docker Installation ********* 033[0m"
echo "================================================================\n\n"

    sudo apt-get update -y
    sudo apt-get install ca-certificates curl gnupg lsb-release

    sudo mkdir -p /etc/apt/keyrings
    sudo rm -rf /etc/apt/keyrings/docker.gpg
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg 

    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    sudo apt-get update -y
    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y
  
    # sudo service docker start
    # sudo systemctl start docker.service
    
    sudo usermod -aG docker ${USER}

echo "\033[0;32m\n\n================================================================\033[0m"
    echo  "\033[0;32m\t  ********* Kubectl Configuration  ********* \033[0m"
echo "\033[0;32m================================================================\n\n"

    curl  -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" >/dev/null 
    chmod +x ./kubectl
    sudo mv ./kubectl /usr/local/bin/kubectl

echo "\033[0;32m\n\n================================================================\033[0m"
    echo  "\033[0;32m\t  ********* k3d install ********* \033[0m"
echo "\033[0;32m================================================================\n\n\033[0m"

which k3d 2>/dev/null
if [ 0 -eq $? ]; then
    sudo rm -rf $(which k3d)
fi

curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash

echo "\033[0;32m\n\n================================================================"
    echo "\033[0;32m\t  ********* clear existing cluster if exists  ********* \033[0m"
echo "\033[0;32m================================================================\n\n\033[0m"

    # sudo systemctl start docker.service



while (true)
    do
        output=$(systemctl status docker.service | grep "Active" | awk '{ print $2 }') >/dev/null 2>&1
         
        if [ "$output" = "active" ]; then
            echo "\033[0;32m Docker is Running .....\033[0m"
            break

        else
            sudo systemctl start docker.service
            echo "\033[0;31m Waiting for Docker to run .....\033[0m"
            sleep 3
        fi
    
    done

    sudo k3d cluster stop aybourasCluster
    sudo k3d cluster delete aybourasCluster

echo "\033[0;32m\n\n================================================================"
    echo "\033[0;32m\t  ********* Create a new k3s cluster (k3s-in-docker)  ********* \033[0m"
echo "\033[0;32m================================================================\n\n\033[0m"

    sudo k3d cluster create aybourasCluster --api-port 10.13.100.207:6443 -p "80:80@loadbalancer"  --k3s-arg "--no-deploy=traefik@server:*" --wait

# sudo k3d cluster list

#    sudo k3d cluster create aybourasCluster --api-port 10.13.100.73:6443 -p "80:80@loadbalancer" --wait

echo "\033[0;32m\n\n================================================================\033[0m"
    echo  "\033[0;32m\t  ********* Installing argocd  ********* \033[0m"
echo "\033[0;32m================================================================\n\n\033[0m"

    sudo curl -sSL -o /usr/local/bin/argocd https://github.com/argoproj/argo-cd/releases/download/$VERSION/argocd-darwin-amd64 
    sudo chmod +x /usr/local/bin/argocd

echo "\033[0;32m\n\n================================================================\033[0m"
    echo  "\033[0;32m\t  ********* Create namespaces ********* \033[0m"
echo "\033[0;32m================================================================\n\n\033[0m"

    sudo kubectl create namespace argocd
    sudo kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml --wait

    sudo kubectl create namespace dev

echo "\033[0;32m\n\n================================================================\033[0m"
    echo  "\033[0;32m\t  ********* Loadbalancer patch  ********* \033[0m"
echo "\033[0;32m================================================================\n\n\033[0m"

    sudo kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
    #sudo kubectl get svc -A
    #sudo kubectl get svc -A --wait
    #sudo kubectl get pod --namespace argocd -w

echo "\033[0;32m\n\n================================================================\033[0m"
    echo  "\033[0;32m\t  ********* Deploying the application  ********* \033[0m"
echo "\033[0;32m================================================================\n\n\033[0m"

    # scp -r -p /Users/aybouras/Desktop/kuber aybouras@10.13.100.75:/home/aybouras/kuber

    # sudo kubectl  apply -f $HOME/kuber/p3/cluster_synced_repo/playground/application.yaml --wait
    # sudo kubectl  apply -f $HOME/kuber/p3/cluster_synced_repo/playground/dev/deployment.yaml --namespace dev --wait
    # sudo kubectl  apply -f $HOME/kuber/p3/cluster_synced_repo/playground/dev/service.yaml --namespace dev --wait

    sudo kubectl  apply -f $HOME/kuber/p3/cluster_synced_repo/application.yaml --wait
    sudo kubectl  apply -f $HOME/kuber/p3/cluster_synced_repo/dev/deployment.yaml --namespace dev --wait
    sudo kubectl  apply -f $HOME/kuber/p3/cluster_synced_repo/dev/service.yaml --namespace dev --wait

    echo  "\033[0;32m\t  *********  ********* \033[0m"

    while (true)
        do
            output=$(sudo kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}") > /dev/null 2>&1
            len=${#output}
            
            if [ $len -eq 24 ]; then 
               
                 echo  "\033[0;32m\t \n\n\nagroCD password is: \n\n \033[0m"
                sudo kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
                break
            fi

            echo "\033[0;31m waiting for argoCD to get ready .....\033[0m"
            sleep 6

        done

    echo "\nvisit the link: \n https://10.13.100.75:80"
    # open -a "Google Chrome" https://10.13.100.75:80
    # open -a "Firefox" https://10.13.100.75:80
