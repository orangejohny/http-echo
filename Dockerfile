# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

FROM --platform=$TARGETPLATFORM golang:1.21-alpine3.18 as default

# TARGETOS and TARGETARCH are set automatically when --platform is provided.
ARG TARGETOS
ARG TARGETARCH

LABEL name="http-echo"

RUN apk --no-cache add make~=4.4 git~=2.40 curl~=8

WORKDIR /build
COPY . .
RUN make bin

EXPOSE 4000/tcp

ENV ECHO_TEXT="hello-world"
ENV TARGETOS=$TARGETOS
ENV TARGETARCH=$TARGETARCH

ENTRYPOINT ["dist/$TARGETOS/$TARGETARCH/http-echo", "--listen=:4000"]
