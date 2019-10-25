
import groovy.util.XmlParser
import org.jdom2.input.SAXBuilder
import org.jetbrains.kotlin.gradle.plugin.mpp.KotlinNativeTarget
import java.io.File



repositories {
    google()
    jcenter()
    maven(url = "https://maven.fabric.io/public")
    maven(url = "https://dl.bintray.com/kotlin/kotlin-eap")
    maven(url = "https://kotlin.bintray.com/kotlinx")
    maven(url = "https://dl.bintray.com/jetbrains/kotlin-native-dependencies")
}

plugins {
    kotlin("multiplatform")
    id("kotlinx-serialization")
   // apply plugin: 'org.jetbrains.kotlin.native.cocoapods'
}

kotlin {
    //select iOS target platform depending on the Xcode environment variables
    val iOSTarget: (String, KotlinNativeTarget.() -> Unit) -> KotlinNativeTarget =
        if (System.getenv("SDK_NAME")?.startsWith("iphoneos") == true)
            ::iosArm64
        else
            ::iosX64

    iOSTarget("ios") {
        binaries {
            framework {
                baseName = "SharedCode"
            }
        }
    }

    jvm("android")

    val sp = sourceSets["commonMain"].kotlin.sourceDirectories.single().absolutePath
    println("Sp is " + sp)

    sourceSets["commonMain"].dependencies {
        implementation("org.jetbrains.kotlin:kotlin-stdlib-common")
       // implementation ("org.jetbrains.kotlinx:kotlinx-coroutines-core:1.3.2")
        implementation("org.jetbrains.kotlinx:kotlinx-coroutines-core-common:1.3.2")
        // Serialize
        implementation ("org.jetbrains.kotlinx:kotlinx-serialization-runtime-common:0.13.0")

        implementation ("io.ktor:ktor-client-core:1.2.4")

        implementation ("io.ktor:ktor-client-json:1.2.4")
        implementation ("io.ktor:ktor-client-logging:1.2.4")
        implementation ("io.ktor:ktor-client-serialization:1.2.4")
        //implementation ("org.jetbrains.kotlinx:kotlinx-coroutines-core")
        //implementation("org.jetbrains.kotlinx:kotlinx-coroutines-core-common")
    }

    sourceSets["androidMain"].dependencies {
        implementation("org.jetbrains.kotlin:kotlin-stdlib")
        implementation ("org.jetbrains.kotlinx:kotlinx-coroutines-android:1.3.2")

        implementation ("io.ktor:ktor-client-android:1.2.4")
        implementation ("io.ktor:ktor-client-core-jvm:1.2.4")

        implementation ("io.ktor:ktor-client-json-jvm:1.2.4")
        implementation ("io.ktor:ktor-client-logging-jvm:1.2.4")
        implementation ("io.ktor:ktor-client-serialization-jvm:1.2.4")
        //implementation ("org.jetbrains.kotlinx:kotlinx-coroutines-core:1.3.0")

    }

    sourceSets["iosMain"].dependencies{
        // Coroutines
        //implementation ("org.jetbrains.kotlinx:kotlinx-coroutines-core:1.3.0")
        //implementation("org.jetbrains.kotlinx:kotlinx-coroutines-core-common:1.3.2")

        implementation ("org.jetbrains.kotlinx:kotlinx-coroutines-core-native:1.3.2")
        // Serialize
       // implementation ("org.jetbrains.kotlinx:kotlinx-serialization-runtime-native:1.3.0")

        // Serialize
        implementation ("org.jetbrains.kotlinx:kotlinx-serialization-runtime-native:0.13.0")

        implementation ("io.ktor:ktor-client-ios:1.2.4")
        implementation ("io.ktor:ktor-client-core-native:1.2.4")

        implementation ("io.ktor:ktor-client-json-native:1.2.4")
        implementation ("io.ktor:ktor-client-logging-native:1.2.4")
        implementation ("io.ktor:ktor-client-serialization-native:1.2.4")
    }
}


val packForXcode by tasks.creating(Sync::class) {
    group = "build"

    //selecting the right configuration for the iOS framework depending on the Xcode environment variables
    val mode = System.getenv("CONFIGURATION") ?: "DEBUG"
    val framework = kotlin.targets.getByName<KotlinNativeTarget>("ios").binaries.getFramework(mode)

    inputs.property("mode", mode)
    dependsOn(framework.linkTask)

    val targetDir = File(buildDir, "xcode-frameworks")
    from({ framework.outputDirectory })
    into(targetDir)

    doLast {
        val gradlew = File(targetDir, "gradlew")
        gradlew.writeText("#!/bin/bash\nexport 'JAVA_HOME=${System.getProperty("java.home")}'\ncd '${rootProject.rootDir}'\n./gradlew \$@\n")
        gradlew.setExecutable(true)
    }
}

tasks.getByName("build").dependsOn(packForXcode)


tasks.getByName("androidProcessResources").dependsOn("resourceConverter")

java {
    sourceCompatibility = JavaVersion.VERSION_1_8
    targetCompatibility = JavaVersion.VERSION_1_8
}

tasks.register("resourceConverter") {

    val baseResourcesPath = "app/src/main/res/values/"

    val builder =  SAXBuilder()
    val colorsSourcePath = baseResourcesPath + "colors.xml"
    val stringsSourcePath = baseResourcesPath + "strings.xml"
    val targetPath   = project.projectDir.resolve("src/commonMain/kotlin/resources")

   
    doLast {
        convert(builder, colorsSourcePath, targetPath.absolutePath, "color")
        println("Generated colors resource object file in common shared")


        convert(builder, stringsSourcePath, targetPath.absolutePath, "string")
        println("Generated strings resource object file in common shared")


    }
}
fun convert(builder: SAXBuilder, sourcePath: String, targetPath: String, identity: String) {
    var nm = project.rootDir.resolve(sourcePath)

    val doc = builder.build(nm)
    val root = doc.rootElement
    val elements = root.getChildren(identity)
    var lines = String()
    elements.forEach {
        lines =
            lines + (" val " + it.getAttributeValue("name") + " = " + "\"" + it.textTrim + "\"" + "\n")
    }

    val className = identity.capitalize() + "s"
    val fileName = className + ".kt"

    File(targetPath, fileName).writeText(

        """//this is gradle generated file. Do not modify. 
package com.kinsight.kinsightmultiplatform.resources  

object ${className} {
$lines}
            """
    )
}