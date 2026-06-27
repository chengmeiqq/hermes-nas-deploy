# Hermes Agent - 飞牛OS NAS Docker 部署配置

基于 [Hermes Agent](https://github.com/hermes-agent/hermes) 的 NAS Docker 部署配置，支持双栈（IPv4 + IPv6）远程访问。

## 功能特性

- 🐳 Docker Compose 一键部署
- 🌐 双栈访问（IPv4 + IPv6）
- 🤖 飞书 Bot 长连接集成
- 🧠 小米 mimo-v2.5 模型支持
- 📊 Dashboard Web 管理界面
- 🔒 基础认证保护

## 快速开始

### 1. 复制配置文件

```bash
cp .env.example .env
cp config.yaml.example config.yaml
```

### 2. 编辑 .env 填入你的密钥

```bash
nano .env
```

### 3. 编辑 config.yaml 填入你的 API 密钥

```bash
nano config.yaml
```

### 4. 启动服务

```bash
docker compose up -d
```

### 5. 访问 Dashboard

- IPv4: http://192.168.0.145:9119
- IPv6: http://[你的IPv6地址]:9119

## 文件说明

| 文件 | 说明 |
|------|------|
| `docker-compose.yml` | Docker Compose 编排文件 |
| `Dockerfile` | 自定义 Hermes 镜像构建文件 |
| `.env.example` | 环境变量模板 |
| `config.yaml.example` | Hermes 配置模板 |
| `scripts/` | IPv6 代理等辅助脚本 |
| `使用文档.md` | 详细使用说明 |

## 注意事项

- ⚠️ 请勿将包含真实密钥的 `.env` 和 `config.yaml` 提交到公开仓库
- 🔑 所有示例文件中的密钥已脱敏，使用前需替换
- 📝 飞书 Bot 需要在[飞书开放平台](https://open.feishu.cn)创建应用

## 许可

MIT License
