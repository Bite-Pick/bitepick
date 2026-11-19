import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")
}

// prod(및 dev 폴백)은 key.properties, dev는 key.dev.properties의 키로 서명한다.
fun loadKeystoreProperties(fileName: String): Properties? {
    val file = rootProject.file(fileName)
    if (!file.exists()) return null
    return Properties().apply { FileInputStream(file).use { load(it) } }
}

val keystoreProperties = loadKeystoreProperties("key.properties")
val devKeystoreProperties = loadKeystoreProperties("key.dev.properties")


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

    signingConfigs {
        fun createSigningConfig(name: String, properties: Properties) {
            create(name) {
                val alias = properties.getProperty("keyAlias")
                val keyPwd = properties.getProperty("keyPassword")
                val storePwd = properties.getProperty("storePassword")
                val storeFilePath = properties.getProperty("storeFile")

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

        keystoreProperties?.let { createSigningConfig("release", it) }
        devKeystoreProperties?.let { createSigningConfig("releaseDev", it) }
    }

    buildTypes {
        getByName("release") {
            // 서명 키는 아래 androidComponents에서 flavor별로 지정한다.
            // keystore가 없으면 기본 signing 설정을 사용한다.

            // ProGuard 활성화
            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }
}

androidComponents {
    onVariants(selector().withBuildType("release")) { variant ->
        val signingConfigs = android.signingConfigs
        // dev는 dev 업로드 키를 쓰고, 파일이 없으면(CI 등) 기존처럼 release 키로 폴백한다.
        val config = when (variant.flavorName) {
            "dev" -> signingConfigs.findByName("releaseDev") ?: signingConfigs.findByName("release")
            else -> signingConfigs.findByName("release")
        }
        if (config != null) {
            variant.signingConfig.setConfig(config)
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.0.4")
}
