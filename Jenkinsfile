pipeline {
    agent any

    options {
        // Keep only the last 5 builds and delete the older ones
        buildDiscarder(logRotator(numToKeepStr: '5'))
    }

    stages {
        //  stage('SonarQube Analysis') {
        //     steps {
        //         withSonarQubeEnv(installationName: 'sq1') {
        //             //sh "dotnet ${env.scannerHome}/SonarScanner.MSBuild.dll begin /k:\"Aula03\""
        //             sh "dotnet sonarscanner begin /k:\"Aula03\""
        //             sh "dotnet build"
        //             // sh "dotnet ${env.scannerHome}/SonarScanner.MSBuild.dll end"
        //             sh "dotnet sonarscanner end"
        //         }
        //     }
        // }

        stage('SonarQube Analysis2') {
            steps {
                script{
                    node(){

                        env.APP_NAME    = "calculadora"
                        env.IMAGE_NAME  = "wellisonraul/${env.APP_NAME}"

                        withInfisical(
                        configuration: [
                            infisicalCredentialId: 'infisical',
                            infisicalEnvironmentSlug: 'dev', 
                            infisicalProjectSlug: 'aula03-4-aak', 
                            infisicalUrl: 'https://app.infisical.com'
                        ],
                        infisicalSecrets: [
                                infisicalSecret(
                                    includeImports: true, 
                                    path: '/', 
                                    secretValues: [
                                        [infisicalKey: 'data1'],
                                        [infisicalKey: "data2"],
                                        [infisicalKey: 'THIS_KEY_MIGHT_NOT_EXIST', isRequired: false],
                                    ]
                                )
                            ]
                        ) {
                        
                        sh 'echo pwd'
                        sh 'ls -l'
                        echo "Compilando, testando e empacotando a aplicação..."
                        app = docker.build("${env.IMAGE_NAME}:${env.BRANCH_NAME}-${env.BUILD_ID}", "--build-arg data1=${env.data1} --build-arg data2=${env.data2} . --no-cache --progress=plain")

                        }
                    }
                }
            }
        }
        // sh "printenv" 
        
        // //sh "git clone https://github.com/wellisonraul/calculadoraJenkins.git ."
        // sh "git checkout aula03; git pull"

        // withSonarQubeEnv(installationName: 'sq1') {
        //     //sh "dotnet ${env.scannerHome}/SonarScanner.MSBuild.dll begin /k:\"Aula03\""
        //     sh "dotnet sonarscanner begin /k:\"Aula03\""
        //     sh "dotnet build"
        //     // sh "dotnet ${env.scannerHome}/SonarScanner.MSBuild.dll end"
        //     sh "dotnet sonarscanner end"
        // }

        
        // echo "Docker image push"
        // docker.withRegistry('https://registry.hub.docker.com/', 'dockerhub') {
        //     app.push("${env.BUILD_ID}")
        //     app.push('latest')
        // }

        // echo "🚀 Realizando o deploy..."

        // Força parar o container antigo se ele existir
        // try {
        //     sh "docker rm -f ${env.APP_NAME}-${env.BRANCH_NAME} || true"
        // } catch (Exception e) {
        //     echo "Nenhum container antigo rodando. Vamos seguir com o deploy novo!"
        // }

        // Roda o novo container
        // docker.image("${env.IMAGE_NAME}:${env.BRANCH_NAME}-${env.BUILD_ID}").run("--name ${env.APP_NAME}-${env.BRANCH_NAME}")

        // echo "✅ Deploy finalizado com sucesso!"


        // stage('Build, testando e empacotando') {
        //     steps {
        //         script {
        //             echo "Compilando, testando e empacotando a aplicação..."
        //             //sh 'docker build -t $APP_NAME:$BRANCH_NAME-$BUILD_NUMBER . --no-cache'  // Exemplo de comando para compilar uma aplicação Dotnet
                    
        //             app = docker.build("${env.IMAGE_NAME}:${env.BRANCH_NAME}-${env.BUILD_ID}", '.')
        //         }
        //     }
        // }

        stage('Docker image push') {
            steps {
                script {
                    /* Push image using withRegistry. */
                    docker.withRegistry('https://registry.hub.docker.com/', 'dockerhub') {
                        app.push("${env.BUILD_ID}")
                        app.push('latest')
                    }
                }
            
            }
        }

        stage('Deploy') {
            steps {
                script {
                    echo "🚀 Realizando o deploy..."

                    // Força parar o container antigo se ele existir
                    try {
                        sh "docker rm -f ${env.APP_NAME}-${env.BRANCH_NAME} || true"
                    } catch (Exception e) {
                        echo "Nenhum container antigo rodando. Vamos seguir com o deploy novo!"
                    }

                    // Roda o novo container
                    docker.image("${env.IMAGE_NAME}:${env.BRANCH_NAME}-${env.BUILD_ID}").run("--name ${env.APP_NAME}-${env.BRANCH_NAME}")


                    echo "✅ Deploy finalizado com sucesso!"
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

