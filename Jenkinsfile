pipeline {
    agent any

    environment {
        AWS_REGION = 'ap-south-1'
        EKS_CLUSTER = 'java-application-cluster'
        KUBECONFIG = '/var/lib/jenkins/.kube/config'
        DOCKER_IMAGE = 'java-application'
        DOCKER_SECRET = 'dockerhub-secret'
    }

    stages {

        stage('Building Docker Image') {
            steps {
                sh "docker build -t ${DOCKER_IMAGE}:${BUILD_NUMBER} ."

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

                        docker tag ${DOCKER_IMAGE}:${BUILD_NUMBER} \
                            ${DOCKER_USERNAME}/${DOCKER_IMAGE}:${BUILD_NUMBER}

                        docker push \
                            ${DOCKER_USERNAME}/${DOCKER_IMAGE}:${BUILD_NUMBER}

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

        stage('Create Docker Hub Pull Secret') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKER_USERNAME',
                    passwordVariable: 'DOCKER_PASSWORD'
                )]) {

                    sh '''
                        echo "Creating/updating Docker Hub Kubernetes secret..."

                        kubectl create secret docker-registry ${DOCKER_SECRET} \
                            --docker-server=https://index.docker.io/v1/ \
                            --docker-username="$DOCKER_USERNAME" \
                            --docker-password="$DOCKER_PASSWORD" \
                            --dry-run=client \
                            -o yaml | kubectl apply -f -

                        echo "Docker Hub pull secret configured successfully"
                    '''
                }
            }
        }

        stage('Deploy to EKS') {
            steps {
                sh '''
                    echo "Deploying Kubernetes manifests..."

                    kubectl apply -f deployment.yaml
                    kubectl apply -f service.yaml

                    echo "Kubernetes manifests deployed successfully"
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
                        echo "Updating application image..."

                        kubectl set image deployment/java-application \
                            java-application=${DOCKER_USERNAME}/${DOCKER_IMAGE}:${BUILD_NUMBER}

                        echo "Waiting for rollout..."

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
                echo "Your Application is deployed successfully on EKS"
                echo "Docker image: ${DOCKER_IMAGE}:${BUILD_NUMBER}"
                echo "Deployment completed successfully"
            }
        }
    }
}


