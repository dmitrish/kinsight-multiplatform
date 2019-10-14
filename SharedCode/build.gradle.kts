import org.jetbrains.kotlin.gradle.plugin.mpp.KotlinNativeTarget

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
