pipeline {
    agent any
    stages {
        stage('Test') {
            steps {
                sh 'node --version'
            }
        }

        stage('Build Image') {
            steps {
                sh 'docker build -t bestbuy-awesome-container .'
            }
        }

        stage('Start container') {
            steps {
                sh 'docker run -d -e PORT=$PORT -e ENV=$ENV -p $PORT:$PORT --name bestbuy-$ENV bestbuy-awesome-container '
            }
        }
    }
}
