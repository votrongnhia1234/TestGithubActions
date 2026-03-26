# -- Giai doan 1: BUILD --
FROM maven:3.9.11-eclipse-temurin-25 AS builder
WORKDIR /app
COPY . .

#Bien dich 
RUN mvn clean package -DskipTests

# -- Giai doan 2: RUNTIME --
FROM eclipse-temurin:25-jre-jammy
WORKDIR /app

# Chỉ lấy file .jar từ builder (GĐ1)
COPY --from=builder /app/target/*.jar app.jar
EXPOSE 8080
# Lệnh "bật công tắc" để chạy ứng dụng
ENTRYPOINT ["java", "-jar", "app.jar"]