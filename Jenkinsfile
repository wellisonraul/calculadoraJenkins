pipeline {
    agent any

    environment {
        APP_NAME = "Calculadora"
        BUILD_DIR = "0.0.1"
    }

    stages {
        stage('Build') {
            steps {
                script {
                    echo "Compilando a aplicação..."
                    sh 'docker build -t $APP_NAME:$BUILD_NUMBER . --no-cache'  // Exemplo de comando para compilar uma aplicação Dotnet
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    echo "Executando testes..."
                    sh 'dotnet test'  // Exemplo de comando para rodar testes
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    echo "Realizando o deploy..."
                    sh 'docker run -d $APP_NAME:$BUILD_NUMBER'  // Rodando o container Docker
                }
            }
        }
    }

    post {
        success {
            echo "Pipeline concluído com sucesso!"
        }
        failure {
            echo "Pipeline falhou!"
        }
    }
}