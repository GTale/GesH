FROM alpine:latest

RUN apk add --no-cache wget

ADD start.sh /start.sh

RUN chmod +x /start.sh

CMD /start.sh
