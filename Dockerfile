FROM nginx:1.17.9-alpine

ENV APP_UID=9999
ENV APP_GID=9999
ENV APP_USER=node

COPY nginx.conf.template /etc/nginx/nginx.conf.template

RUN addgroup -S -g $APP_GID $APP_USER \
	&& adduser -S -u $APP_UID -G $APP_USER $APP_USER \
	&& chown -R $APP_UID:$APP_GID /etc/nginx/ \
	&& chown -R $APP_UID:$APP_GID /var/cache \
	&& chown -R $APP_UID:$APP_GID /var/log/nginx \
	&& chown -R $APP_UID:$APP_GID /run \
	&& rm -rf /var/cache/apk/*

USER $APP_UID

CMD envsubst '$PORT,$DOWNSTREAM_HOST,$DOWNSTREAM_PORT' < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf \
	&& cat /etc/nginx/nginx.conf \
	&& exec nginx -g 'daemon off;'
