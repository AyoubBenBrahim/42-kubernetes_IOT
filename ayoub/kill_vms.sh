 echo "*** list all existing vms ***"
vboxmanage list vms
echo "*** list running vms ***"
vboxmanage list runningvms
echo "*** poweroff running vms ***"
VBoxManage list runningvms | awk '{print $2;}' | xargs -I vmid VBoxManage controlvm vmid poweroff
echo "*** delete  vms ***"
 VBoxManage list vms | awk '{print $2;}' | xargs -I vmid VBoxManage unregistervm --delete vmid
