pipeline {
    agent any 
    
    stages{
        
        stage('Clonning')
        {
           steps{
               git url: "https://github.com/Pruthviraj7733/containerize-application.git", branch: "main"
               echo "Clonning cod is sucessfull!!"
           }
        }
        
        stage('Buiding Docker Image')
        {
            steps{
                sh "docker build -t java-application:${BUILD_NUMBER} ."
                echo "docker image build sucessfully"
                sh "docker image ls"
                echo "Thank you so much jenkins"
            }
        }
        
        stage('Delete Old Container')
        {
           steps{
                sh "docker container rm -f myapplication"
                echo "Old Container Deleted Sucessfully"
                sh "docker container ls"
           }
        }
        
        stage('Running New Container')
        {
            steps{
                
                sh "docker container run -itd --name myapplication -p 9090:8080 java-application:${BUILD_NUMBER}"
                echo "Docker Container Running Sucessfully"
            }
        }

        stage('Wait for Application') {
        steps {
            sh '''
            echo "Waiting for application to start..."

            for i in {1..6}
            do
                curl -sf http://localhost:9090/java-application/ && exit 0
                sleep 5 
            done 
            exit 1
        '''
    }
}

        stage('Application Testing')
        {
            steps{
                echo "Is my docker image created?"
                sh "docker image ls"
                echo "Is my docker container are running?"
                sh "docker container ls"
                echo "Is my apache tomcat process running"
                sh "ps -ef | grep apache"
                echo "Is my port 9090 listening"
                sh "ss -tulpn | grep 9090"
                echo "Is my application running on 9090 port?"
                sh "curl localhost:9090/java-application/"
                echo "Test Validation done"
                
            }
        }
        
       stage('Sucess')
       {
           steps{
              echo "Your Application is deployed sucessfully on docker!!!"
           }
       }
    }
}
