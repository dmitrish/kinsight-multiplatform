[![official JetBrains project](https://jb.gg/badges/official.svg)](https://confluence.jetbrains.com/display/ALL/JetBrains+on+GitHub)
[![GitHub license](https://img.shields.io/badge/license-Apache%20License%202.0-blue.svg?style=flat)](https://www.apache.org/licenses/LICENSE-2.0)

# Kotlin Multiplatform project: Sharing code between iOS, MacOS, WatchOS, Android (phone and watch - Wear OS), and JVM Web Server (Ktor)

KInsight Alpha Capture is a proof of concept project currently being developed for our annual CodeWeek event (where you pitch business or technology ideas). 
Alpha Capture app is intended for Sales to create and distribute trade ideas to our institutional clients. The app will track the performance of each idea relative to the performance of the benchmark, and alert users when the idea has reached the price objective or stop loss value so that the user can then close the idea.
This is proof of concept only, and as such will have the following limitations: 1) there will be only limited live market data availability (when creating an idea, current stock price - for this we use https://iexcloud.io/docs/api/ - if you clone this project, make sure to get your own api key - it's free!); b) there will be no permanent storage for newly created ideas, they will be stored in memory on the server until the next server reload.
However, there will be a number of “prefabricated” ideas along with their historical (mocked) performance.
As we cannot control the market (alas), some market data manipulation is in order. The server will provide an API to update prices for ideas so that an alert can be triggered. These price updates will flow into the app via websockets, updating UI in real time and triggering notification alerts when price objective or stop loss thresholds are met.

# Overview

![overview](https://github.com/dmitrish/kinsight-multiplatform/blob/master/overview.png)



<table style="width:100%">
  <tr>
    <th>IPhone</th>
    <th>Android</th> 
 
  </tr>
  <tr>
    <td><img src="https://github.com/dmitrish/kinsight-multiplatform/blob/master/iphoneplay.gif"/></td>
    <td><img src="https://github.com/dmitrish/kinsight-multiplatform/blob/master/androidplay.gif"/></td> 

  </tr>
  
</table>

<table style="width:100%">
  <tr>
    <th>Wear OS</th>
    <th>Watch OS</th> 
 
  </tr>
  <tr>
    <td>
 <img src="https://github.com/dmitrish/kinsight-multiplatform/blob/master/wearos.gif"/>
  </td>
    <td>Coming soon!</td> 

  </tr>
  
</table>

https://github.com/dmitrish/kinsight-multiplatform/blob/master/wearos-alpha.mp4

# Screenshots:



![screens](https://github.com/dmitrish/kinsight-multiplatform/blob/master/welcomesidebyside1.png)


![ideas side by side](https://github.com/dmitrish/kinsight-multiplatform/blob/master/ideastogethernewdesign.png)

# Ideas list - Android

![ideas list android](https://github.com/dmitrish/kinsight-multiplatform/blob/master/ideas-android.jpg)




# Ideas (new design)

![android and iphone detail](https://github.com/dmitrish/kinsight-multiplatform/blob/master/ideadetailsidebyside.png)

# Idea Graph:

![idea graph](https://github.com/dmitrish/kinsight-multiplatform/blob/master/idea-graph-iphone.png)

# Idea Alert (Android):

![idea alert](https://github.com/dmitrish/kinsight-multiplatform/blob/master/idea-created-alert-android.jpg)


# MacOS - Ideas

![idea list macos](https://github.com/dmitrish/kinsight-multiplatform/blob/master/macos-ideas.png)


# Steps to build different server flavors and run them locally

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


# Kotlin Native iOS project: Steps to run iOS project
# Note: XCode 11 is required
1. Compile the shared code module in Android Studio (see snapshot below).
2. Move to Kotlin ios Folder
3. Do a 'pod install'
4. Open .xcworkspace file

# Steps to run Android app
1. Compile the shared code module in Android Studio (see snapshot below)
2. In Android's build.gradle, in Android -> DefaultConfig -> change this build config field to be:
buildConfigField("String", "url", '"https://10.0.2.2:8081"')



# Build shared code first - before running android, ios or server!

![build shared module](https://github.com/dmitrish/kinsight-multiplatform/blob/master/buildsharedcode.png)

# Steps to deploy Server



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
    docker tag server-all gcr.io/project-kinsight/server-all-image:V3
2. Push Image to cloud registry
    docker push gcr.io/project-kinsight/server-all-image:V3

Next follow below to deploy Docker image into Google Kubernetes Engine:
https://cloud.google.com/kubernetes-engine/docs/quickstart
