plugins {
    alias(libs.plugins.kotlin.jvm)
    application
}

repositories { mavenCentral() }

dependencies {
    testImplementation("org.jetbrains.kotlin:kotlin-test-junit5")
    testImplementation(libs.junit.jupiter.engine)
    testRuntimeOnly("org.junit.platform:junit-platform-launcher")
    implementation(libs.guava)
}

java { toolchain { languageVersion = JavaLanguageVersion.of(21) } }

application { mainClass = "org.example.AppKt" }

tasks.named<Test>("test") { useJUnitPlatform() }

// This task creates a fat JAR that includes all dependencies, including the
// Kotlin standard library and any other dependencies.
tasks.withType<Jar> {
    manifest { attributes["Main-Class"] = "org.example.AppKt" }
    duplicatesStrategy = DuplicatesStrategy.EXCLUDE
    from(sourceSets.main.get().output)
    dependsOn(configurations.runtimeClasspath)
    from({
        configurations.runtimeClasspath
            .get()
            .filter { it.name.endsWith("jar") }
            .map { zipTree(it) }
    })
}
