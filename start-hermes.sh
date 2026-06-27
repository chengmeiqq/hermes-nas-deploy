#!/bin/bash
# 等待 Docker 就绪
for i in $(seq 1 60); do
    if docker info >/dev/null 2>&1; then
        break
    fi
    sleep 1
done

cd /vol1/1000/docker/hermes

# 确保容器运行
docker compose up -d --force-recreate

# IPv6 反向代理
if ! pgrep -f "hermes-ipv6-proxy" >/dev/null 2>&1; then
    /vol1/1000/docker/hermes/scripts/hermes-ipv6-proxy.sh &
fi

echo "Hermes started at $(date)" >> /tmp/hermes-boot.log
