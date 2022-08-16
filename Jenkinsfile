pipeline {
    agent any
    tools {nodejs "NodeJS"}
    stages {
        stage('verifying tools') {
            steps {
                sh ''' #! /bin/bash npm --version '''
            }
        }
        stage('Build') {
            steps {
                sh ''' #! /bin/bash 
                cd ./app
                npm cache clean --force
                npm install 
                zip -r app.zip *
                '''
            }
	}
// 	stage ('Test') {
// 	steps {
// 		sh ''' #! /bin/bash
// 		npm run test:coverage
// 		#above command will create a coverage folder which will be used by sonarScanner
// 		#CI=true (only if needed, if the test are stuck)
// 		'''
// 	}			
        stage('Deploy') {
            steps {
                sh ''' #! /bin/bash 
                ls
                pwd
                cd ./app
                ls
                '''
               withAWS(region:'us-east-1',credentials:'aws') {
                s3Upload(file:'/var/lib/jenkins/workspace/CiCd-demo-nodejs/app/app.zip', bucket:'cicd-demo-jenkins')
		createDeployment( s3Bucket : 'cicd-demo-jenkins', applicationName : 'cicd-demo', deploymentGroupName : 'DG1', s3Key : 'app.zip', s3BundleType : 'zip')
// 		aws deploy create-deployment --application-name  --deployment-group-name  --deployment-config-name CodeDeployDefault.AllAtOnce --s3-location bucket=,bundleType=zip,key='app'.zip
//           sh '
//           aws s3 cp ./target/demo-0.0.1-SNAPSHOT.jar s3://jenkins-test-javaupload/demo-0.0.1-SNAPSHOT.jar '
		       
                }
	    		
            }
        }
    }
    post {
        always {
            echo 'Stage is success'
        }
    }
}
