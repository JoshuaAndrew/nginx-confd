FROM nginx
RUN apt-get -yqq update && \
    apt-get -yqq upgrade && apt-get -yqq install curl

RUN cd /usr/local/bin \
  && curl -L https://github.com/kelseyhightower/confd/releases/download/v0.12.0-alpha3/confd-0.12.0-alpha3-linux-amd64 -o confd \
  && chmod +x confd

RUN rm -rf /etc/nginx/nginx.conf

COPY nginx.toml /etc/confd/conf.d/nginx.toml
COPY nginx.tmpl /etc/confd/templates/nginx.tmpl
COPY confd-watch /usr/local/bin/confd-watch

RUN chmod +x /usr/local/bin/confd-watch

EXPOSE 80 443
