# Vagrant com Observabilidade Kubernetes Integrada

Este projeto Vagrant cria um ambiente de desenvolvimento completo para observabilidade Kubernetes, incluindo:

* **Kind:** Um cluster Kubernetes local para testes e desenvolvimento.
* **Kube Prometheus:** Um conjunto de ferramentas de monitoramento Kubernetes baseado em Prometheus.
* **InfluxDB:** Um banco de dados de séries temporais para armazenamento de métricas.
* **Grafana:** Uma plataforma de visualização de dados para dashboards e alertas.
* **Alertmanager:** Um sistema de gerenciamento de alertas.

## Pré-requisitos

* **Vagrant:** Instalado na sua máquina.
* **VirtualBox ou libvirt:** Um provedor de virtualização para Vagrant.
* **kubectl:** Instalado para interagir com o cluster Kubernetes.

## Como Executar

1.  **Clone o repositório:**

    ```bash
    git clone <URL\_do\_repositório>
    cd <nome\_do\_repositório>
    ```

2.  **Inicie o ambiente Vagrant:**

    Na raiz do projeto, execute o seguinte comando:

    ```bash
    vagrant up
    ```

    Este comando irá:

    * Criar uma máquina virtual.
    * Instalar o Docker e o Kind.
    * Criar um cluster Kubernetes Kind.
    * Implantar o Kube Prometheus, InfluxDB, Grafana e Loki.

3.  **Acesse o cluster Kubernetes:**

    Após a conclusão do \`vagrant up\`, você pode acessar o cluster Kubernetes usando o \`kubectl\`. O arquivo de configuração do \`kubectl\` será configurado automaticamente.

    ```bash
    vagrant ssh
    sudo kubectl get nodes
    ```

4.  **Acesse as interfaces de observabilidade:**

    Para acessar as interfaces de observabilidade, é necessário realizar o port forwarding das portas dos serviços para sua máquina local. Isso pode ser feito usando o comando \`kubectl port-forward\`. Por exemplo:

    ```bash
    vagrant ssh
    sudo su \\ vire superusuário
    ```

    * **Grafana:**

        ```bash
        kubectl port-forward --namespace monitoring service/grafana 3000:3000 --address 0.0.0.0 &
        ```

        Em seguida, acesse \`http://SEUIP:3000\` (usuário/senha padrão: admin/admin).

    * **Prometheus:**

        ```bash
        kubectl port-forward --namespace monitoring service/prometheus-k8s 9090:9090 --address 0.0.0.0 &
        ```

        Em seguida, acesse \`http://SEUIP:9090\`.

    * **Alertmanager:**

        ```bash
        kubectl port-forward --namespace monitoring service/alertmanager-main 9093:9093 --address 0.0.0.0 &
        ```

        Em seguida, acesse \`http://SEUIP:9093\`.


    * **InfluxDB:**

        ```bash
        kubectl port-forward --namespace influxdb influxdb-influxdb-0 8086:8086 --address 0.0.0.0 &
        ```

        Em seguida, acesse \`http://SEUIP:8086\`.

## Configuração

* O arquivo \`Vagrantfile\` contém a configuração da máquina virtual e as instruções de provisionamento.
* Os arquivos de configuração do Helm estão localizados no diretório \`helm\`.
* Você pode personalizar as configurações do Prometheus, Grafana, Loki e Alertmanager modificando os arquivos de configuração do Helm.

## Observações

* Este ambiente é projetado para desenvolvimento e teste.
* Para um ambiente de produção, considere usar um cluster Kubernetes gerenciado e ferramentas de observabilidade dedicadas.
* Este projeto fornece um ponto de partida para explorar a observabilidade Kubernetes.

## Próximos Passos

* Explore os dashboards e alertas pré-configurados no Grafana.
* Implante suas próprias aplicações no cluster Kubernetes e monitore-as com o Kube Prometheus.
* Personalize as configurações do Prometheus, Grafana, Loki e Alertmanager para atender às suas necessidades.
* Aprenda mais sobre as ferramentas de observabilidade Kubernetes.