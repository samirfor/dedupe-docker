FROM python:3.5-alpine

RUN set -ex \
        && apk add --no-cache --virtual .build-deps \
                ca-certificates \
                gcc \
                g++ \
                curl \
                git \
        && ln -s /usr/include/locale.h /usr/include/xlocale.h

ENV DEDUPE_VERSION=bb25eff3e9050124546198e9bec00fe0eed47868
ENV PIP_INSTALL="pip3 install --verbose --no-cache-dir --disable-pip-version-check"

RUN set -ex \
        && ${PIP_INSTALL} numpy>=1.11

WORKDIR /dedupe

RUN set -ex \
        && git clone --verbose https://github.com/datamade/dedupe.git . \
        && git checkout ${DEDUPE_VERSION}

RUN set -ex \
        && ${PIP_INSTALL} -r requirements.txt

RUN set -ex \
        && cython src/*.pyx

RUN set -ex \
        && ${PIP_INSTALL} -e .

RUN set -ex \
        && apk del .build-deps \
        && cd / \
        && rm -rf /dedupe
