# Repo
/etc/yum.repos.d/kubernetes.repo 
```
[kubernetes]
name=kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
exclude=kube*
```

kubeadm init --pod-network-cidr=10.244.0.0/16 --kubernetes-version=v1.11.3 --ignore-preflight-errors all

kubeadm join 10.0.1.185:6443 --token phlyf3.9y2kicbgc9s2af3m --discovery-token-ca-cert-hash sha256:cd8d332d943d8f932cece955ea56fd92dcd7eeaeefa30f40bc3e0d6f72341d3e

To start using your cluster, you need to run the following as a regular user:
```
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/v0.9.1/Documentation/kube-flannel.yml

lesson2

kubeadm join 10.0.1.156:6443 --token 9464rg.20ry2buooibhw6w4 --discovery-token-ca-cert-hash sha256:8eada221c9bf4ebffce0611aa4bf1d8b39089232f8c838561d36c635e8f918b7

deployment.yml
```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: httpd-deployment
  labels:
    app: httpd
spec:
  replicas: 3
  selector:
    matchLabels:
      app: httpd
  template:
    metadata:
      labels:
        app: httpd
    spec:
      containers:
      - name: httpd
        image: httpd:latest
        ports:
        - containerPort: 80
```
kubectl create -f deployment.yml


kubectl get pods


service.yml
```
apiVersion: v1
kind: Service
metadata:
  name: service-deployment
spec:
  selector:
    app: httpd
  ports:
  - protocol: TCP
    port: 80
    targetPort: 80
  type: NodePort
```
kubectl get services