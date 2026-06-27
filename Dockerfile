FROM nousresearch/hermes-agent:latest

# 复制配置文件到镜像
COPY ./data/ /opt/data/
COPY ./docker-compose.yml /opt/docker-compose.yml
COPY ./start-hermes.sh /opt/start-hermes.sh
COPY ./scripts/ /opt/scripts/

# 设置权限
RUN chmod +x /opt/start-hermes.sh && \
    chmod -R 777 /opt/data/ && \
    chmod -R 777 /opt/scripts/

# 设置工作目录
WORKDIR /opt

# 默认启动 gateway
CMD ["gateway", "run"]
