pipeline {
    agent any

    environment {
        DOCKER_HUB_USER = "praniknikose"
        DOCKER_HUB_IMAGE = "notesapp2"
        DOCKER_HUB_TAG = "1.0"
        K8S_NAMESPACE = "notesapp2-ns"
    }

    stages {
        stage('Checkout Code') {
            steps {
                git url: 'https://github.com/PranikNikose/NotesApp2.git', branch: 'main'
            }
        }

        stage('Build WAR') {
            steps {
                sh 'mvn clean package'   // build WAR
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $DOCKER_HUB_USER/$DOCKER_HUB_IMAGE:$DOCKER_HUB_TAG .'
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'Pranik-DockerHubCreds', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                    sh 'echo $PASS | docker login -u $USER --password-stdin'
                    sh 'docker push $DOCKER_HUB_USER/$DOCKER_HUB_IMAGE:$DOCKER_HUB_TAG'
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh """
                kubectl apply -f notesapp2-ns.yml
                kubectl apply -f notesapp2-deployment.yml
                kubectl apply -f notesapp2-svc.yml
                """
            }
        }
    }
}
