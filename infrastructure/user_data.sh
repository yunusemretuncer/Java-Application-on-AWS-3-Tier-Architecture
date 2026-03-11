#!/bin/bash
set -e

yum update -y
amazon-linux-extras install -y nginx1 || yum install -y nginx
yum install -y java-17-amazon-corretto
yum install -y aws-cli

mkdir -p /opt/app
cd /opt/app

aws s3 cp s3://yunus-java-login-app-bucket/app.jar app.jar

nohup java -jar app.jar > app.log 2>&1 &

sleep 10

cat >/etc/nginx/conf.d/app.conf <<'NGINX'
server {
    listen 80 default_server;
    server_name _;

    location /health {
        return 200 "ok\n";
        add_header Content-Type text/plain;
    }
     location / {
        root /usr/share/nginx/html;
        index index.html;
    }

    location /app/ {
        proxy_pass http://127.0.0.1:8080/;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}
NGINX

echo "<h1>Deployed via Terraform ASG in dev</h1>" > /usr/share/nginx/html/index.html

nginx -t
systemctl enable nginx
systemctl restart nginx