FROM jenkins/jenkins:lts

# deploy jenkins and jenkins plugins
ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

USER root
RUN apt-get update

# install docker engine
# Ref: https://docs.docker.com/install/linux/docker-ce/debian/#install-using-the-repository
RUN apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common
RUN curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | apt-key add -
RUN add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo \"$ID\") \
   $(lsb_release -cs) \
   stable"
RUN apt-get update
RUN apt-get install -y docker-ce docker-ce-cli containerd.io
RUN usermod -a -G docker jenkins

# install jenkins-job-builder
RUN apt-get update
RUN apt-get install -y python python-dev python-pip
RUN pip install --upgrade pip
RUN pip install jenkins-job-builder
