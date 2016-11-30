FROM python:3.5-alpine

RUN set -ex \
        && apk add --no-cache --virtual .build-deps \
                ca-certificates \
                gcc \
                g++ \
                curl \
        && ln -s /usr/include/locale.h /usr/include/xlocale.h \
        && pip3 install --no-cache-dir --disable-pip-version-check numpy==1.11.0 \
        && pip3 install --no-cache-dir --disable-pip-version-check dedupe \
        && apk del .build-deps
