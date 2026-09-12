pipeline {
    agent any

    environment {
        AWS_REGION = 'ap-south-1'
        EKS_CLUSTER = 'java-application-cluster'
        KUBECONFIG = '/var/lib/jenkins/.kube/config'
    }

    stages {

        stage('Building Docker Image') {
            steps {
                sh "docker build -t java-application:${BUILD_NUMBER} ."

                echo "Docker image built successfully"

                sh "docker image ls"
            }
        }

        stage('Push Image to Docker Hub') {
            steps {

                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKER_USERNAME',
                    passwordVariable: 'DOCKER_PASSWORD'
                )]) {

                    sh '''
                        echo "$DOCKER_PASSWORD" | docker login \
                            -u "$DOCKER_USERNAME" \
                            --password-stdin

                        docker tag java-application:${BUILD_NUMBER} \
                            ${DOCKER_USERNAME}/java-application:${BUILD_NUMBER}

                        docker push \
                            ${DOCKER_USERNAME}/java-application:${BUILD_NUMBER}

                        docker logout
                    '''
                }
            }
        }

        stage('Check EKS Connection') {
            steps {

                sh '''
                    echo "Checking AWS identity..."
                    aws sts get-caller-identity

                    echo "Checking EKS nodes..."
                    kubectl get nodes
                '''
            }
        }

        stage('Deploy to EKS') {
            steps {

                sh '''
                    kubectl apply -f deployment.yaml
                    kubectl apply -f service.yaml
                '''
            }
        }

        stage('Update Application Image') {
            steps {

                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKER_USERNAME',
                    passwordVariable: 'DOCKER_PASSWORD'
                )]) {

                    sh '''
                        kubectl set image deployment/java-application \
                            java-application=${DOCKER_USERNAME}/java-application:${BUILD_NUMBER}

                        kubectl rollout status deployment/java-application \
                            --timeout=180s
                    '''
                }
            }
        }

        stage('Application Testing') {
            steps {

                echo "Checking Kubernetes nodes..."
                sh "kubectl get nodes"

                echo "Checking application deployment..."
                sh "kubectl get deployment java-application"

                echo "Checking application Pods..."
                sh "kubectl get pods -o wide"

                echo "Checking application Service..."
                sh "kubectl get svc java-application-service"

                echo "EKS deployment validation completed"
            }
        }

        stage('Success') {
            steps {

                echo "Your Application is deployed successfully on EKS!!!"
            }
        }
    }
}
