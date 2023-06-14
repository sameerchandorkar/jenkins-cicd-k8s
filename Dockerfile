FROM alpine:latest

RUN apk --no-cache add nginx
RUN mkdir -p /run/nginx

CMD ["nginx", "-g", "daemon off;"]
