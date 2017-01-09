FROM python:3.5-alpine

ENV DEDUPE_VERSION=1.6.0

RUN set -ex \
        && apk add --no-cache --virtual .build-deps \
                ca-certificates \
                gcc \
                g++ \
                curl \
        && ln -s /usr/include/locale.h /usr/include/xlocale.h \
        && pip3 install --no-cache-dir --disable-pip-version-check numpy>=1.9 \
        && pip3 install --no-cache-dir --disable-pip-version-check dedupe==${DEDUPE_VERSION} \
        && apk del .build-deps
