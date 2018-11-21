pipeline {
    agent { dockerfile true }
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
                sh 'docker run -d -e PORT=$port --name bestbuy-$ENV bestbuy-awesome-container -p $port:$port'
            }
        }
    }
}
