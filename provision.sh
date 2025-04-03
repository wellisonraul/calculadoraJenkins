#!/bin/bash
set -e  # Exit on first error

echo "Updating system..."
export DEBIAN_FRONTEND=noninteractive
sudo apt-get update && sudo apt-get upgrade -y

sudo apt install apache2 -y

echo "Installing dependencies..."
sudo apt-get install -y ca-certificates curl apt-transport-https software-properties-common

echo "Installing Docker..."
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL --connect-timeout 10 https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

echo "Installing Kubectl..."
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

echo "Installing Kind..."
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.27.0/kind-linux-amd64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind
sudo wget https://raw.githubusercontent.com/wellisonraul/calculadoraJenkins/refs/heads/aula07/kind-config.yaml
sudo kind create cluster --config kind-config.yaml

# Install Loki and Promtail
echo "Instalando Loki e Promtail"
sudo mkdir -p /etc/apt/keyrings/
sudo wget -q -O - https://apt.grafana.com/gpg.key | gpg --dearmor > /etc/apt/keyrings/grafana.gpg
echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com stable main" | tee /etc/apt/sources.list.d/grafana.list
sudo apt update
sudo apt install loki promtail -y

# Install Telegraf
wget -q https://repos.influxdata.com/influxdata-archive_compat.key
sudo echo '393e8779c89ac8d958f81f942f9ad7fb82a25e133faddaf92e15b16e6ac9ce4c influxdata-archive_compat.key' | sha256sum -c && cat influxdata-archive_compat.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/influxdata-archive_compat.gpg > /dev/null
sudo echo 'deb [signed-by=/etc/apt/trusted.gpg.d/influxdata-archive_compat.gpg] https://repos.influxdata.com/debian stable main' | sudo tee /etc/apt/sources.list.d/influxdata.list
sudo apt-get update && sudo apt install telegraf -y

echo "Installing Prometheus/Grafana/Kube-State-Metrics..."
git clone https://github.com/prometheus-operator/kube-prometheus.git
cd kube-prometheus/
sudo kubectl apply --server-side -f manifests/setup
sudo kubectl wait \
	--for condition=Established \
	--all CustomResourceDefinition \
	--namespace=monitoring
sudo kubectl apply -f manifests/

echo "Installing InfluxDB"
kubectl apply -f https://raw.githubusercontent.com/influxdata/docs-v2/master/static/downloads/influxdb-k8-minikube.yaml