FROM alpine:12

LABEL maintainer="ManishKhadka@protonmail.com" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.name="unameme/blackbox-stackexchange" \
    org.label-schema.description="Dockerized StackExchange Blackbox." \
    org.label-schema.url="https://github.com/unamem/blackbox-docker" \
    org.label-schema.vcs-url="https://github.com/unamem/blackbox-docker" \
    org.label-schema.vendor="Manish Khadka" \
    org.label-schema.docker.cmd="docker run -it unameme/blackbox-stackexchange:v0.1"

RUN apk update && \
    apk install gnupg git bash

RUN apk add --update make

#download blackbox
RUN git clone https://github.com/StackExchange/blackbox.git

RUN cd blackbox && \
    make copy-install

