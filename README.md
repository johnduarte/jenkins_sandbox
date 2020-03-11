# Jenkins Sandbox

This repository provides a local sandbox for deploying and working with Jenkins.


## Local Jenkins and JJB deploy
This setup is based on the following:
https://technologyconversations.com/2017/06/16/automating-jenkins-docker-setup/
https://github.com/jsallis/docker-jenkins-job-builder


## Usage
All commands shown below are executed from within the root of your checkout of
this repo.


### Build Jenkins Docker Image
This will build the docker image containing Jenkins.
```
docker image build -t jenkins_sandbox -f Dockerfile .
```

### Run Docker container
Here we run a docker container from the image generated above. The Jenkins web
interface port is mapped to port 8080 locally so that we can access it from the
browser on our local system. The current directory is mounted within the
container.  The local docker socket is also mounted within the container to
allow Jenkins pipelines to execute docker containers.

```
CONTAINER_ID=$(docker run -d \
  -p 8080:8080 \
  --volume "$PWD":/opt/jenkins-job \
  --volume /var/run/docker.sock:/var/run/docker.sock \
  jenkins_sandbox)
```
