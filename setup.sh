#!/bin/sh

# 检查 docker-compose 和 docker compose 并设置环境变量
if command -v docker-compose >/dev/null 2>&1; then
    export DOCKER_COMPOSE="docker-compose"
elif command -v docker >/dev/null 2>&1 && docker compose version >/dev/null 2>&1; then
    export DOCKER_COMPOSE="docker compose"
else
    echo "Error: Please install either docker-compose or docker compose."
    exit 1
fi

# 检查 rpk 命令是否存在
if command -v rpk >/dev/null 2>&1; then
    # 如果 rpk 已存在，则不输出任何内容
    :
else
    # 如果 rpk 不存在，则进行安装
    curl -LO https://github.com/redpanda-data/redpanda/releases/latest/download/rpk-linux-amd64.zip &&
    mkdir -p "$CONDA_PREFIX/bin" &&
    unzip rpk-linux-amd64.zip -d "$CONDA_PREFIX/bin/" &&
    rm rpk-linux-amd64.zip

    # 确保安装成功
    if command -v rpk >/dev/null 2>&1; then
        echo "rpk has been installed successfully."
    else
        echo "Error: rpk installation failed."
        exit 1
    fi
fi

