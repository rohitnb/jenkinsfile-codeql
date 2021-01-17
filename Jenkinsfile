pipeline {
  agent any
  stages {
    stage('CodeQL Scan') {
      environment {
        GITHUB_CREDS = credentials('<JENKINS_CREDENTIAL_ID>') 
      }
      steps {
        sh '''
CODEQL_PATH="/path/to/codeql/cli" #<---- Modify this
CODEQL_RUNNER_PATH="/path/to/codeql/runner" #<---- Modify this

GITHUB_HOST="`echo $GIT_URL | cut -d'/' -f3`" 
GITHUB_ORG="`echo $GIT_URL | cut -d'/' -f4`"
GITHUB_REPO="`echo $GIT_URL | cut -d'/' -f5| sed -e 's/\\.git//g'`"

if [ -z $CHANGE_ID ]
then
      #If this is not a Pull Request
      GIT_REF=`git symbolic-ref HEAD`
else
      GIT_REF="refs/pull/$CHANGE_ID/merge"
      GIT_COMMIT=`curl -s --location --request GET "https://$GITHUB_HOST/api/v3/repos/$GITHUB_ORG/$GITHUB_REPO/pulls/$CHANGE_ID" --header 'Accept: application/vnd.github.v3+json' --header "Authorization: token $GITHUB_CREDS_PSW" | jq '.merge_commit_sha' | sed -e 's/\"//g'`
fi
echo "====DEBUG===="
echo "GITHUB_HOST is $GITHUB_HOST, GITHUB_ORG is $GITHUB_ORG, GITHUB_REPO is $GITHUB_REPO"
echo "====END DEBUG==="
$CODEQL_RUNNER_PATH init --repository $GITHUB_ORG/$GITHUB_REPO --github-url https://$GITHUB_HOST --github-auth $GITHUB_CREDS_PSW --codeql-path $CODEQL_PATH
$CODEQL_RUNNER_PATH analyze --repository $GITHUB_ORG/$GITHUB_REPO --github-url https://$GITHUB_HOST --github-auth $GITHUB_CREDS_PSW --commit $GIT_COMMIT --ref $GIT_REF'''
      }
    }

  }
}
