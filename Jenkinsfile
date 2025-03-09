pipeline {
    agent any

    environment {
        APP_NAME = "calculadora-" + env.BRANCH_NAME
        BUILD_DIR = "0.0.1"
    }

    stages {
        stage('Build, testando e empacotando') {
            steps {
                script {
                    echo "Compilando, testando e empacotando a aplicação..."
                    sh 'docker build -t $APP_NAME:$BUILD_NUMBER . --no-cache'  // Exemplo de comando para compilar uma aplicação Dotnet
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