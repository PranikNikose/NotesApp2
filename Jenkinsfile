pipeline {
    agent any

    environment {
        DOCKER_HUB_USER = "praniknikose"
        DOCKER_HUB_IMAGE = "notesapp"
        DOCKER_HUB_TAG = "latest"
        K8S_NAMESPACE = "notesapp-ns"
    }

    stages {
        stage('Checkout Code') {
            steps {
                git url: 'https://github.com/<your_user>/<repo>.git', branch: 'main'
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
                kubectl apply -f k8s-namespace.yaml
                kubectl apply -f k8s-deployment.yaml
                kubectl apply -f k8s-service.yaml
                """
            }
        }
    }
}
