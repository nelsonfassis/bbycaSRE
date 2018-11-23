pipeline {
    environment {
        registry = "nelsonfassis/operations"
        registryCredential = 'dockerhub-credentials'
        dockerImage = ''
    }
    agent any
    stages {
        stage('Test') {
            steps {
                script {
                    withEnv(['ENV=DEV','PORT=8091']) {
                        sh 'echo "Testing $ENV env on port $PORT \n\n"'
                        sh 'node bestbuy.ca.js & '

                        String RESULT = sh(script: 'curl -s -o /dev/null -w "%{http_code}\n" localhost:$PORT/', returnStdout: true)
                        echo "Status Code $RESULT"

                        if ( RESULT.trim() == '200') {
                            echo 'Test succeeded'
                            sh 'pkill node'
                        } else {
                            echo "Status Code FAILED $RESULT"
                            echo 'Test failed'
                            sh 'pkill node'
                            sh 'exit 1 '
                        }
                    }
              }
            }
        }

        stage('Push Image to DockerHub'){
          steps {
            echo "Pushing image to DockerHub"
            script {
              dockerImage = docker.build registry + ":$BUILD_NUMBER"
              docker.withRegistry( '', registryCredential ) {
                dockerImage.push()
              }
            }
          }
        }

        stage('Start container') {
            steps {
                sh 'docker stop bestbuy-$ENV || true && docker rm bestbuy-$ENV || true'
                sh 'docker run --restart=always -d -e PORT=$PORT -e ENV=$ENV -p $PORT:$PORT --name bestbuy-$ENV $registry:$BUILD_NUMBER '
            }
        }
    }
}
