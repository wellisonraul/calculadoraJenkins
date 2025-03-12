pipeline {
    agent any

    environment {
        APP_NAME = "wellisonraul/calculadora"
        BRANCH_NAME = GIT_BRANCH.replaceFirst(/^origin\//, '')
        BUILD_DIR = "${env.BUILD_ID}"
    }

    stages {
        stage('Build, testando e empacotando') {
            steps {
                script {
                    echo "Compilando, testando e empacotando a aplicação..."
                    sh 'docker build -t $APP_NAME:$BRANCH_NAME-$BUILD_NUMBER . --no-cache'  // Exemplo de comando para compilar uma aplicação Dotnet
                }
            }
        }

        stage('Docker image push') {
            steps {
                script {
                    echo "Enviando imagens para o docker hub"
                    sh 'docker login'
                    sh 'docker image push $APP_NAME:$BRANCH_NAME-$BUILD_NUMBER'  // Exemplo de comando para compilar uma aplicação Dotnet
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    echo "Realizando o deploy..."
                    sh 'docker rm -f  $APP_NAME-$BRANCH_NAME'
                    sh 'docker run --name $APP_NAME-$BRANCH_NAME -d $APP_NAME:$BRANCH_NAME-$BUILD_NUMBER'  // Rodando o container Docker
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