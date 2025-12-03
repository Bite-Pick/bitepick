import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")
}

// Load keystore properties from key.properties file
val keystorePropertiesFile = rootProject.file("key.properties")
val keystoreProperties = Properties().apply {
    if (keystorePropertiesFile.exists()) {
        load(FileInputStream(keystorePropertiesFile))
    }
}


android {
    namespace = "com.trendflow.bitepick"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11

        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.trendflow.bitepick"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    flavorDimensions += "app"
    productFlavors {
        create("dev") {
            dimension = "app"
            applicationIdSuffix = ".dev"
            resValue("string", "app_name", "바이트픽 DEV")
        }
        create("prod") {
            dimension = "app"
            resValue("string", "app_name", "바이트픽")
        }
    }

    val hasKeystore = keystorePropertiesFile.exists()

    signingConfigs {
        if (hasKeystore) {
            create("release") {
                val alias = keystoreProperties.getProperty("keyAlias")
                val keyPwd = keystoreProperties.getProperty("keyPassword")
                val storePwd = keystoreProperties.getProperty("storePassword")
                val storeFilePath = keystoreProperties.getProperty("storeFile")

                if (!alias.isNullOrBlank()) {
                    keyAlias = alias
                }
                if (!keyPwd.isNullOrBlank()) {
                    keyPassword = keyPwd
                }
                if (!storePwd.isNullOrBlank()) {
                    storePassword = storePwd
                }
                if (!storeFilePath.isNullOrBlank()) {
                    storeFile = file(storeFilePath)
                }
            }
        }
    }

    buildTypes {
        getByName("release") {
            if (hasKeystore) {
                signingConfig = signingConfigs.getByName("release")
            }
            // else: keystore 없으면 기본 signing 설정 사용
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // Firebase Cloud Messaging
    implementation(platform("com.google.firebase:firebase-bom:33.7.0"))
    implementation("com.google.firebase:firebase-messaging-ktx")

    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.0.4")
}
