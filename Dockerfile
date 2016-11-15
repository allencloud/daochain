FROM python:2.7-alpine

MAINTAINER DCS <dao@daocloud.io> 

ADD . /app

WORKDIR /app/cli

ADD app/dist/* /app/cli/server/static

RUN apk add --no-cache --virtual .build-deps  \
		bzip2-dev \
		gcc \
		gdbm-dev \
		libc-dev \
		linux-headers \
		make \
		ncurses-dev \
		openssl \
		openssl-dev \
		pax-utils \
		readline-dev \
		sqlite-dev \
		tcl-dev \
		tk \
		tk-dev \
		zlib-dev \
	&& pip install --no-cache-dir -r requirements.pip \
	&& apk del .build-deps \
	&& rm -rf /usr/src/python ~/.cache


ENV ETH_RPC_ENDPOINT=localhost:8545
ENV HUB_ENDPOINT=http://api.daocloud.co

VOLUME /var/run/docker.sock

EXPOSE 8000

CMD [ "python", "server/gunicorn_runner.py" ]