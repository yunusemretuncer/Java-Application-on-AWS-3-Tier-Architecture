#!/bin/bash
set -e

# --- packages ---
yum update -y
amazon-linux-extras install -y nginx1 || yum install -y nginx
yum install -y python3

# --- simple python backend (port 8080) ---
mkdir -p /opt/backend

cat >/opt/backend/app.py <<'PY'
from http.server import BaseHTTPRequestHandler, HTTPServer

class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        if self.path in ["/health", "/health/"]:
            self.send_response(200)
            self.send_header("Content-Type", "text/plain")
            self.end_headers()
            self.wfile.write(b"ok\n")
            return
        if self.path in ["/", "/app", "/app/"]:
            self.send_response(200)
            self.send_header("Content-Type", "text/plain")
            self.end_headers()
            self.wfile.write(b"backend ok\n")
            return

        self.send_response(404)
        self.end_headers()

HTTPServer(("0.0.0.0", 8080), Handler).serve_forever()
PY

cat >/etc/systemd/system/backend.service <<'SERVICE'
[Unit]
Description=Simple Python Backend
After=network.target

[Service]
ExecStart=/usr/bin/python3 /opt/backend/app.py
Restart=always
User=root

[Install]
WantedBy=multi-user.target
SERVICE

systemctl daemon-reload
systemctl enable --now backend

# --- nginx: serve / and /health, proxy /app/ to backend ---
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
