# kubernetes


Vagrant is a tool that simplifies the workflow and reduces the workload necessary to run and operate virtual machines (VMs) on your computer. 

K8s comes from “Kubernetes” where there are eight characters between the K and the S. 

https://www.vagrantup.com/docs

https://rancher.com/docs/k3s/latest/en/quick-start/

Provisioning
In Vagrant’s terminology, the process of automatic installation and configuration of software within the guest OS during $ vagrant up is called provisioning and the tools to perform this operation are called provisioners.

Vagrant has built-in support for many popular configuration management tools:
Shell scripts
Puppet
Ansible
Chef
By default, provisioning is executed only during the first run of $ vagrant up


instead of loading the VM every time with vag up, load only the immage of centos and do the configuration inside manually

curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--node-ip=192.168.42.110 --flannel-iface=eth1 --write-kubeconfig-mode=644" sh -

and retry if smthg failed

/usr/local/bin/k3s-killall.sh
/usr/local/bin/k3s-uninstall.sh


https://gist.github.com/pcrete/811be0e1573afd3b3a67db1770c82e92

====

p2


Kubernetes Deployment?
    Kubernetes deployment is an abstraction describing how your application will be deployed.
    It describes your Kubernetes cluster
    Once you set up a deployment, it will automatically create pods, incorporating multiple containers. Each pod is connected to the Node. Once that Node fails, your identical PODs will get scheduled on other variable Nodes included in your Kubernetes cluster.
    Using a deployment allows you to easily keep a group of identical pods running with a common configuration.

Kubernetes Services? 
    It's an abstraction that describes your Kubernetes cluster. 
    Its role is to make your application available to the networks that your cluster's connected to. In short, it exposes it to the outside world...
    In a nutshell, a service in Kubernetes is no more than a load balancer in Kubernetes. It will just send traffic to your app in a round-robin way: network requests get spread across the ecosystem of the running pods.

A deployment is responsible for keeping a set of pods running.
A service is responsible for enabling network access to a set of pods. 

while Kubernetes deployment is "in charge" with keeping the pods running in the cluster, a service is in charge of granting network access to those pods.

Deployments working to define the desired state of the application and Services working to make sure communication between almost any kind of resource and the rest of the cluster is stable and adaptable. 


Part 3

k3s
(Rancher Lab’s minimal Kubernetes distribution) 

lightweight tool designed to run production-level Kubernetes on local machines. 
In order to achieve this, they remove a lot of extra drivers that didn’t need 
to be part of the core and are easily replace with add-ons.
k3s clusters provide an environment that simulates the standard k8s

K3d

k3d is an open-source utility designed to easily run highly available lightweight k3s clusters in a docker container.

With k3d you can easily create single and multi-node k3s clusters for seamless local development and testing on Kubernetes.
By running in Kubernetes, k3d also helps you to scale your workload up and down without more effort.

k3d is a wrapper of k3s but one of the apparent differences is that k3s deploys a virtual machine-based 
Kubernetes cluster while k3d deploys Docker-based k3s Kubernetes clusters.


One of the key differences is that k3d deploys Docker-based k3s Kubernetes clusters while k3s deploys a virtual machine-based Kubernetes cluster.
K3d offers a more scalable version of k3s which might make it preferable to the standard k3s.
k3d appears to be a more flexible and improved version of k3s even though their features and usage are similar.


k3s-in-docker in Go


a Namespace?
You can think of a Namespace as a virtual cluster inside your Kubernetes cluster.
 You can have multiple namespaces inside a single Kubernetes cluster, and they are all logically isolated from each other.


======

IP addresses for Kubernetes pods are not persistent because the system assigns each new pod a new IP address.
 Typically, therefore, direct communication between pods is impossible.
  However, services have their own relatively stable IP addresses which field requests from external resources. 
  The service then dispatches the request to an available Kubernetes pod.



