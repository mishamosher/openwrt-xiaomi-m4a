FROM alpine:edge
# fetch dnsmasq
RUN apk update \
	&& apk --no-cache add dnsmasq \
	&& apk add --no-cache --virtual .build-deps curl \
	&& apk del .build-deps
#configure dnsmasq
RUN mkdir -p /etc/default/ /tftpboot
RUN echo -e "ENABLED=1\nIGNORE_RESOLVCONF=yes" > /etc/default/dnsmasq
COPY dnsmasq.conf /etc/dnsmasq.conf
#run!
ENTRYPOINT ["dnsmasq","--no-daemon"]
