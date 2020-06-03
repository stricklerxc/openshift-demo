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

                // Deploy openshift template using Openshift Jenkins Plugin
                openshiftDeploy(
                    depCfg: 'openshift-dev.yml',
                    apiURL: 'https://127.0.0.1:8443',
                    namespace: 'local-dev',
                    authToken: 'g2hrOy-f3lIqf-fNtvf4HGjtke4nAVaFQrGfIkGKQKk'
                )
            }
        }
    }
}
