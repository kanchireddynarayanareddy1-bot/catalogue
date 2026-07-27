pipeline {
    agent {
        node {
            label 'Agent-1'
        }
    }
    environment { 
        Course= "Jenkins"
        appVersion= ""
    }
    options {
        timeout(time: 10, unit: 'MINUTES')  
    }
    stages {
        // this is buuild section check the build section for githubwebhook
        stage('ReadVersion') {
            steps {
                script {
                    // Read JSON file into an object
                    def packageJson = readJSON file: 'package.json'
                    
                    // Extract the version property
                    def appVersion = packageJson.version
                    // Print the version
                    echo "Application Version: ${appVersion}"
                }
                
            }
        }
        stage('Install Dependencies') {
            steps {
                script {
                    sh """
                        npm install
                    """
                }
            }    
        }
        // stage('BuildImages') {
        //     steps {
        //         script {
        //             sh """
        //                docker build -t catalogue:${appVersion} .
        //                docker images
        //             """
        //         }
        //     }    
        // }
        stage('Deploy') {
            input {
                message "Should we continue?"
                ok "Yes, we should."
                submitter "alice,bob"
                parameters {
                    string(name: 'PERSON', defaultValue: 'Mr Jenkins', description: 'Who should I say hello to?')
                }
            }
            steps {
                script {
                    sh """
                        echo 'Deploying..'
                        echo "Hello ${Course}"
                    """
                    
                }
            }
        }
    }
    post {
        always {
            echo 'This will always run'
            cleanWs()
        }
        success {
            echo 'This will run only if successful'
        }
        failure {
            echo 'This will run only if failed'
        }
    }
}