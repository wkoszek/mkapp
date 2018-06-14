FROM alpine:3.6

ENV APPDIR /app
WORKDIR	$APPDIR
ADD . $APPDIR

## APK local mirror for fast download
ENV APK_MIRROR_ADDR 192.168.50.1
ENV APK_MIRROR_PORT 9012
ENV APK_DIR1 http://${APK_MIRROR_ADDR}:${APK_MIRROR_PORT}/alpine/v3.7/main
ENV APK_DIR2 http://${APK_MIRROR_ADDR}:${APK_MIRROR_PORT}/alpine/v3.7/community

#ENV APK_DIR1 http://dl-cdn.alpinelinux.org/alpine/v3.7/main
#ENV APK_DIR2 http://dl-cdn.alpinelinux.org/alpine/v3.7/community

ENV APKCMD "apk --allow-untrusted"

RUN	echo ${APK_DIR1} >  /etc/apk/repositories && \
	echo ${APK_DIR2} >> /etc/apk/repositories && \
	cat /etc/apk/repositories && \
	$APKCMD update && \
	$APKCMD add ruby ruby-json ruby-bundler && \
	cd /app && \
	./vendor/bin/bundle install --local

#	gem install bundler --no-document && \
#	ruby-dev make g++ gcc && \

EXPOSE 80

CMD [ "./vendor/bin/bundle", "exec", "ruby", "/app/app.rb" ]
