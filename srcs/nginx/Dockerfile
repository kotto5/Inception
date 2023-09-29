# ベースイメージとしてAlpineを使用
FROM alpine:latest

# nginxをインストール
RUN apk update && apk add nginx
RUN apk add bash

# 必要に応じて設定ファイルやコンテンツをコピー
# COPY nginx.conf /etc/nginx/nginx.conf
# COPY content/ /usr/share/nginx/html/

# nginxのログファイルのシンボリックリンクをstdoutとstderrに作成
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

# nginxを実行
CMD ["nginx", "-g", "daemon off;"]  