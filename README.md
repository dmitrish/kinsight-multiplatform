[![official JetBrains project](https://jb.gg/badges/official.svg)](https://confluence.jetbrains.com/display/ALL/JetBrains+on+GitHub)
[![GitHub license](https://img.shields.io/badge/license-Apache%20License%202.0-blue.svg?style=flat)](https://www.apache.org/licenses/LICENSE-2.0)

# Kotlin Multiplafrorm project: Sharing code between iOS, Android, and JVM Web Server (Ktor)

![screens](https://github.com/dmitrish/kinsight-multiplatform/blob/master/Screen%20Shot%202019-11-07%20at%209.06.33%20PM.png)

Switching server between thee possible builds: google app angine, netty, and netty with fatjar - settings.gradle:
![Switching server between google app engine and netty builds](https://github.com/dmitrish/kinsight-multiplatform/blob/master/settingsgradle.png)

If you want to run the google appengine locally, remember to change the engine path to your path!

![appengine path](https://github.com/dmitrish/kinsight-multiplatform/blob/master/googleappenginepath.png)

To run appengine locally, execute this gradle task

![appengine run task](https://github.com/dmitrish/kinsight-multiplatform/blob/master/googleappenginerun.png)


Note - if you want websockets enabled, you need to run one of the netty builds (regular netty or fatjar netty). Change settings.gradle as described above and execute this gradle task for the regular netty build:

![netty run task](https://github.com/dmitrish/kinsight-multiplatform/blob/master/nettyrun.png)


To run the fatjar build, first build with this build task:
![fatjar build task](https://github.com/dmitrish/kinsight-multiplatform/blob/master/fatjargradletask.png)



Then navigate to the libs folder in the terminal and execute: libs % java -jar server-all.jar


GOOGLE APP ENGINE and DOCKER - COMMANDS
---------------------------------------

Prerequisite install Google Cloud SDK and Docker(optional)

Create Google Project:
1. gcloud init
2. gcloud projects create kinsight-multiplatform
3. gcloud app create
4. gcloud config set project kinsight-multiplatform
5. gcloud auth configure-docker

Create Docker Image and Run:

1. Navigate to \server folder
2. docker build -t server-all .
3. docker run -m512M --cpus 1 --expose 8081 -p 8081:8081 -it server-all

Other Docker Commands:
    docker images
    docker ps
    docker stop instance_id
    docker rmi image_name

Uploading Docker Image to Google Cloud Registry:

1. Add Tag to Image (V3 is the tag here)
    docker tag quickstart-image gcr.io/project-kinsight/server-all-image:V3
2. Push Image to cloud registry
    docker push gcr.io/project-kinsight/server-all-image:V3

Next follow below to deploy Docker image into Google Kubernetes Engine:
https://cloud.google.com/kubernetes-engine/docs/quickstart
