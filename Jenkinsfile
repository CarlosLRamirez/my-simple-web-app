pipeline {
    agent any
    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/CarlosLRamirez/my-simple-web-app.git'
            }
        }
        stage('Deploy to Server') {
            steps {
                sshagent(['your-ssh-credentials-id']) {
                    sh '''
                    ssh -o StrictHostKeyChecking=no ubuntu@172.16.101.128 "
                    cd /var/www/my-webapp && git pull origin main && sudo systemctl restart nginx"
                    '''
                }
            }
        }
    }
}
