pipeline {
    agent any 
    triggers {
        pollSCM '* * * * *' // Verifica cambios cada minuto 
    }
    stages {
        stage('Checkout') {
            steps {
                checkout scm 
            }
        }
        stage('Deploy') {
            steps {
                sh './deploy.sh' 
            }
        }
    }
}
