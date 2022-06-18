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


====

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


