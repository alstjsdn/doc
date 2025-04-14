FROM jenkins/jenkins:lts
USER root

RUN apt-get update && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    software-properties-common

# Docker GPG key 및 저장소 설정 (Debian-compatible)
RUN install -m 0755 -d /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg && \
    echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
    bullseye stable" > /etc/apt/sources.list.d/docker.list

# 패키지 업데이트 및 docker-ce-cli 설치
RUN apt-get update && apt-get install -y docker-ce-cli

# docker-compose 설치
RUN curl -L "https://github.com/docker/compose/releases/download/v2.11.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose

# Jenkins 유저에 docker 그룹 권한 추가
RUN groupadd -f docker && usermod -aG docker jenkins