pipeline {
    agent any

    stages {
        stage('Setup') {
            steps {
                // Run unit tests
                sh "./mvnw clean test"

                // Build docker image
                sh "docker build -f Dockerfile -t stricklerxc/demo:latest"

                // Push docker image to DockerHub
                withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                    sh """
                        docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD
                        docker push stricklerxc/demo:latest
                    """
                }

                script {
                    def ocpConfig = readFile('openshift-dev.yml')
                }

                // Deploy openshift template using Openshift Jenkins Plugin
                openshiftCreateResource(
                    jsonyaml: ocpConfig,
                    apiURL: 'https://192.168.1.151:8443',
                    namespace: 'local-dev',
                    authToken: 'g2hrOy-f3lIqf-fNtvf4HGjtke4nAVaFQrGfIkGKQKk'
                )
            }
        }
    }
}
