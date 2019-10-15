FROM golang:1.13.1 AS builder

ENV VERSION=v2.1

WORKDIR /usr/src/myapp
COPY . .

# 编译
RUN /bin/bash build.sh ${VERSION}

FROM ubuntu:16.04

LABEL maintainer "29ygq@sina.com"

# 安装依赖
RUN apt update -y \
    && apt install -y locales \
    && rm -rf /var/lib/apt/lists/* \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 \
    && apt update -y \
    && apt install -y fonts-wqy-zenhei fonts-wqy-microhei \
    && apt install -y xdg-utils wget xz-utils python chromium-browser \
    && rm -rf /var/lib/apt/lists/* \
    && wget -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sh /dev/stdin

ENV LANG en_US.utf8

# 将程序拷贝进去
COPY . /BookStack/
COPY --from=builder /usr/src/myapp/output/linux/BookStack /BookStack/

# 将程序拷贝进去
COPY lib/time/zoneinfo.zip /usr/local/go/lib/time/

WORKDIR /BookStack/

RUN chmod +x start.sh

CMD ["./start.sh"]
