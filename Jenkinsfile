// environment {
   
// }

node{

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

        sh "printenv" 

        git clone "https://github.com/wellisonraul/calculadoraJenkins.git"

        echo "Compilando, testando e empacotando a aplicação..."
        app = docker.build("${env.IMAGE_NAME}:${env.BRANCH_NAME}-${env.BUILD_ID}", '. --no-cache')

        echo "Docker image push"
        docker.withRegistry('https://registry.hub.docker.com/', 'dockerhub') {
            app.push("${env.BUILD_ID}")
            app.push('latest')
        }

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