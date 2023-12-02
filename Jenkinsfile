node {
  stage('Clone repository') {
    git credentialsId: 'github_access_token', url: 'https://github.com/kwantke/JenkinsTest.git'
  }
  stage('Build image') {
    dockerImage = docker.build("kwangko/test:v1.0")
  }
  stage('Push image') {
    withDockerRegistry([ credentialsId: "docker-access", url: "" ]) {
      dockerImage.push()
    }
  }
}