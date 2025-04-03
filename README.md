Markdown

# Aplicação Docker com Observabilidade Integrada

Esta branch demonstra como executar uma aplicação Docker com um conjunto completo de ferramentas de observabilidade pré-configuradas usando Docker Compose.

## Componentes

* **Prometheus:** Coleta métricas da aplicação e de outros serviços.
* **Grafana:** Visualiza métricas e logs em dashboards personalizados.
* **InfluxDB:** Banco de dados de séries temporais para armazenar métricas.
* **Loki:** Sistema de agregação e consulta de logs.
* **Servidor de Métricas:** Uma aplicação de exemplo que gera métricas para demonstração.
* **Alertmanager:** Gerencia e envia alertas com base nas métricas do Prometheus.

## Pré-requisitos

* Docker instalado e em execução.
* Docker Compose instalado.

## Como Executar

1.  **Clone o repositório:**

    ```bash
    git clone <URL_do_repositório>
    cd <nome_do_repositório>
    ```

2.  **Execute a aplicação com Docker Compose:**

    Certifique-se de que o arquivo `docker-compose.yml` está presente na raiz do projeto. Em seguida, execute o seguinte comando:

    ```bash
    docker-compose up -d
    ```

    * A flag `-d` executa os contêineres em modo "detached" (em segundo plano).
    * Para visualizar os logs dos contêineres, use: `docker-compose logs -f`.
    * Para parar e remover os contêineres, use: `docker-compose down`.

3.  **Acesse as interfaces:**

    * **Grafana:** `http://localhost:3000` (usuário/senha padrão: admin/admin)
    * **Prometheus:** `http://localhost:9090`
    * **Alertmanager:** `http://localhost:9093`
    * **Loki:** `http://localhost:3100`
    * **Server:** `http://localhost:8090`
    * **NodeExporter:** `http://localhost:9100`
    * **InfluxDB:** `http://localhost:8086`