# kvm usage



## create new vm

Ensure the iso specified in `create-new-headless-alpine.sh` is present in the local dir.

    ./create-new-headless-alpine.sh myvm 2 1024 50


## setup alpine:

Create a new answerfile.myvm.conf from answerfile.conf.
Change the hostname and anything other relevant.

in the vm:

    cat > answerfile.conf <<-EOF
    <paste in the ./answerfile.myvm.conf>
    EOF

    setup-alpine -f answerfile.conf

answer the remaining questions and reboot.

    reboot

install curl!

    apk add -u curl

install k3s!

    export K3S_TOKEN='<your-k3s token from your k3s-control'
    export K3S_URL=https://<ip-to-your-k3s-control>:6443
    curl -L https://get.k3s.io > k3s-install.sh
    /bin/sh k3s-install.sh




## label the new node

kubectl label node <mynode> pool=default
