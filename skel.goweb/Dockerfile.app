FROM scratch

ENV APPDIR /app
WORKDIR	$APPDIR
#ADD . $APPDIR
ADD linux.app /app/linux.app

EXPOSE 8081

CMD [ "/app/linux.app" ]