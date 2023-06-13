FROM ubuntu:latest

ARG USER_NAME=agent0
ARG USER_UID=1138
ARG USER_GID=$USER_UID
ENV TZ=America/Los_Angeles
ENV DEBIAN_FRONTEND=noninteractive

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN groupadd --gid ${USER_GID} ${USER_NAME} && useradd --uid ${USER_UID} --gid ${USER_GID} -m ${USER_NAME}
RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install -y sudo 
RUN echo $USER_NAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USER_NAME 
RUN chmod 0665 /etc/sudoers.d/$USER_NAME
USER $USER_NAME

RUN sudo apt-get install -y \
    curl \
    gnupg \
    git \
    locales \
    procps \
    dirmngr \
    wget \
    net-tools \
    iputils-ping \
    p7zip-full \
    p7zip-rar \
    nmap \
    dnsutils \
    sqlmap \
    tcpdump \
    nikto \
    python3 \
    python3-pip \
    neovim \
    netcat \
    smbclient \
    nbtscan \
    postgresql \
    postgresql-contrib \
    sqlite3 \
    hping3

# RUN sudo echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
# RUN sudo locale-gen

ENV LANG=en_US.UTF-8  
ENV LANGUAGE=en_US:en  
ENV LC_ALL=en_US.UTF-8  

RUN sudo mkdir /opt/hal
COPY . /opt/hal
WORKDIR /opt/hal
RUN make
RUN sh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v1.1.5/zsh-in-docker.sh)" -- \
    -t jonathan
