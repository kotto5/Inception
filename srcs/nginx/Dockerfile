# ベースイメージとしてAlpineを使用
FROM alpine:3.19

# nginxをインストール
RUN apk update \
    && apk add nginx \
    && apk add openssl \
# nginxのログファイルのシンボリックリンクをstdoutとstderrに作成
    && ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log \
# 秘密鍵の生成 create secret key
    && openssl genrsa 2048 > /etc/nginx/secret.key \
# 証明書の生成 create certificate
    && openssl req -x509 -nodes -days 30 \
        -subj "/C=JP/ST=Tokyo/L=Tokyo/O=42tokyo/OU=student/CN=kakiba.web/emailAddress=kakiba@student.42tokyo.jp"\
        -key /etc/nginx/secret.key -out /etc/nginx/secret.crt

COPY ./conf /etc/nginx/

# nginxを実行
CMD ["nginx", "-g", "daemon off;"]
