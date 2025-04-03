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

1.  **Clone o repositório (opcional):**

    Se a aplicação estiver em um repositório Git, clone-o para sua máquina local:

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

## Configuração

* **Variáveis de Ambiente:**

    As variáveis de ambiente podem ser definidas no arquivo `docker-compose.yml` ou em um arquivo `.env` na mesma pasta.

    * Exemplo no `docker-compose.yml`:

        ```yaml
        services:
          nome-do-servico:
            environment:
              VARIAVEL1: valor1
              VARIAVEL2: valor2
        ```

    * Exemplo no `.env`:

        ```
        VARIAVEL1=valor1
        VARIAVEL2=valor2
        ```

* **Volumes:**

    Se a aplicação usa volumes para persistência de dados, eles são definidos no arquivo `docker-compose.yml`.

    * Exemplo:

        ```yaml
        services:
          nome-do-servico:
            volumes:
              - /caminho/local:/caminho/no/container
        ```

* **Portas:**

    As portas expostas pelos contêineres são definidas no arquivo `docker-compose.yml`.

    * Exemplo:

        ```yaml
        services:
          nome-do-servico:
            ports:
              - "porta-da-sua-máquina:porta-do-container"
        ```

* **Redes:**

    Se a aplicação usa redes personalizadas, elas são definidas no arquivo `docker-compose.yml`.

    * Exemplo:

        ```yaml
        networks:
          nome-da-rede:
            driver: bridge

        services:
          nome-do-servico:
            networks:
              - nome-da-rede
        ```

## Observações

* Este README fornece um guia básico para iniciar a aplicação.
* Você pode personalizar as configurações do Prometheus, Grafana, Loki e Alertmanager para atender às suas necessidades específicas.
* Explore os dashboards e alertas pré-configurados no Grafana para entender como a observabilidade funciona neste ambiente.
* Para um ambiente de produção, considere usar volumes persistentes para armazenar dados importantes.