  Vagrant.configure("2") do |config|  # Correção: Vagrantfile deve usar "2" como versão
    # VM para rodar o Kubernetes
    config.vm.define "k8s" do |k8s|  # Correção: agora a variável interna é "k8s"
      k8s.vm.box = "bento/ubuntu-24.04"
      
      k8s.vm.hostname = "k8s"
      k8s.vm.network "public_network"
      k8s.vm.network "forwarded_port", guest: 80, host: 8081
      k8s.vm.provider "virtualbox" do |vb|
        vb.memory = "4096"
        vb.cpus = 2
      end
      k8s.vm.provision "shell", path: "provision.sh"
    end
  end