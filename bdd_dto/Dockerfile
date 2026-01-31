# 1️⃣ Imagen base con Java
FROM eclipse-temurin:17-jdk-alpine

# 2️⃣ Directorio de trabajo
WORKDIR /app

# 3️⃣ Copiar el jar
COPY target/bdd_dto-0.0.1-SNAPSHOT.jar app.jar

# 4️⃣ Exponer el puerto
EXPOSE 9090

# 5️⃣ Ejecutar la app
ENTRYPOINT ["java", "-jar", "app.jar"]
