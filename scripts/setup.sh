STAGE=$1
CONFIG_FILE="/home/ubuntu/config.json"

JAVA_VERSION=$(jq -r '.java_version' $CONFIG_FILE)
REPO_URL=$(jq -r '.repo_url' $CONFIG_FILE)
echo $JAVA_VERSION  >> java.txt
echo $REPO_URL >> repo.txt
sudo apt update -y
sudo apt install -y openjdk-${JAVA_VERSION}-jdk git unzip

echo "export JAVA_HOME=/usr/lib/jvm/java-${JAVA_VERSION}-openjdk-amd64" | sudo tee -a /etc/profile
echo 'export PATH=$JAVA_HOME/bin:$PATH' | sudo tee -a /etc/profile
source /etc/profile

java -version > /home/ubuntu/java_check.txt 2>&1

sudo git clone $REPO_URL /home/ubuntu/techeazy-devops
sudo chown -R ubuntu:ubuntu /home/ubuntu/techeazy-devops

cd /home/ubuntu/techeazy-devops
sudo chmod +x mvnw
sudo nohup ./mvnw spring-boot:run -Dspring-boot.run.arguments=--server.port=80 > /home/ubuntu/spring.log 2>&1 &

SHUTDOWN_AFTER=$(jq -r '.shutdown_after_minutes' $CONFIG_FILE)
echo "sudo shutdown -h +$SHUTDOWN_AFTER" | at now
