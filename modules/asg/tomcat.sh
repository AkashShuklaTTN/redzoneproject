#!bin/bash

sudo apt-get update -y
sudo apt-get install default-jdk -y

#installing springboot application

sudo apt install unzip zip
curl -s https://get.sdkman.io | bash
sudo source "/home/ubuntu/.sdkman/bin/sdkman-init.sh"

sdk install springboot
#sudo apt install spring
#sudo update-alternatives --config java

#cd /etc/
#sudo chmod 777 environment
#echo 'JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64/bin/java"' >> environment
#source /etc/environment
#cd ~

sdk install gradle 4.5.1

spring init --build=gradle --dependencies=web --name=hello hello-world

#create a java application file

cd hello-world
sudo rm src/main/java/com/example/helloworld/HelloApplication.java
sudo touch src/main/java/com/example/helloworld/HelloApplication.java
cd src/main/java/com/example/helloworld/

echo "package com.example.helloworld;" | sudo tee -a HelloApplication.java
echo "import org.springframework.boot.SpringApplication;" | sudo tee -a HelloApplication.java
echo "import org.springframework.boot.autoconfigure.SpringBootApplication;" |sudo tee -a HelloApplication.java
echo "import org.springframework.web.bind.annotation.RestController;" |sudo tee -a HelloApplication.java
               echo "import org.springframework.web.bind.annotation.RequestMapping;" | sudo tee -a  HelloApplication.java
echo "@SpringBootApplication" |sudo tee -a HelloApplication.java
echo "public class HelloApplication {" | sudo tee -a HelloApplication.java
echo "public static void main(String[] args) {" | sudo tee -a HelloApplication.java
echo "SpringApplication.run(HelloApplication.class, args);"| sudo tee -a  HelloApplication.java
echo "}"| sudo tee -a HelloApplication.java
echo "}"| sudo tee -a  HelloApplication.java
echo "@RestController" | sudo tee -a  HelloApplication.java
echo "class Hello {" | sudo tee -a  HelloApplication.java
echo '@RequestMapping("/")' | sudo tee -a  HelloApplication.java
echo "String index() {" | sudo tee -a HelloApplication.java
echo 'return "Hello world";' | sudo tee -a HelloApplication.java
echo "}" | sudo tee -a HelloApplication.java
echo "}" | sudo tee -a HelloApplication.java

#build using gradle

cd ~
cd hello-world
./gradlew build
sudo nohup ./gradlew bootRun > log.txt 2>&1 &
                                                                                           cd ~

#creating a service file
sudo rm /etc/systemd/system/helloworld.service
sudo touch /etc/systemd/system/helloworld.service


cd /etc/systemd/system/

echo "[Unit]" | sudo tee -a helloworld.service
echo "Description=Spring Boot HelloWorld" | sudo tee -a helloworld.servicee
echo "After=syslog.target" | sudo tee -a helloworld.service
echo "After=network.target[Service]" | sudo tee -a helloworld.service
echo "User=root" | sudo tee -a helloworld.service
echo "Type=simple" | sudo tee -a helloworld.service
echo "" | sudo tee -a helloworld.service
echo "[Service]" | sudo tee -a helloworld.service
echo "ExecStart=/usr/bin/java -jar /root/hello-world/build/libs/hello-world-0.0.1-SNAPSHOT.jar" | sudo tee -a helloworld.service
echo "Restart=always" | sudo tee -a helloworld.service
echo "StandardOutput=syslog" | sudo tee -a helloworld.service
echo "StandardError=syslog" | sudo tee -a helloworld.service
echo "SyslogIdentifier=helloworld" | sudo tee -a helloworld.service
echo "" | sudo tee -a helloworld.service
echo "[Install]" | sudo tee -a helloworld.service
echo "WantedBy=multi-user.target" | sudo tee -a helloworld.service


sudo systemctl daemon-reload

sudo systemctl start helloworld
sudo systemctl enable helloworld
sudo systemctl status helloworld
cd ~


#installing nginx and setting reverse proxy

sudo apt-get install nginx -y
cd /etc/nginx/conf.d/
sudo rm helloworld.conf
sudo touch helloworld.conf

echo "server {" | sudo tee -a helloworld.conf
echo "listen 80;" | sudo tee -a helloworld.conf
echo "listen [::]:80;" | sudo tee -a helloworld.conf
echo "server_name java-example.com;" | sudo tee -a helloworld.conf
echo "location / {" | sudo tee -a helloworld.conf
echo "proxy_pass http://localhost:8080/;" | sudo tee -a helloworld.conf
echo "proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;" | sudo tee -a helloworld.conf
echo "proxy_set_header X-Forwarded-Proto \$scheme;" | sudo tee -a helloworld.conf
echo "proxy_set_header X-Forwarded-Port \$server_port;" | sudo tee -a helloworld.conf
echo "}" | sudo tee -a helloworld.conf
echo "}" | sudo tee -a helloworld.conf

sudo systemctl restart nginx
cd ~


#cd ~
#cd hello-world
#./gradlew bootRun
