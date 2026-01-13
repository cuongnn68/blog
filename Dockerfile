FROM golang AS build-server
WORKDIR /build-server
COPY server .
RUN go build -o ./build/server main.go

FROM golang AS build-hugo
RUN apt-get update &&  \
  go install github.com/gohugoio/hugo@latest
WORKDIR /build-hugo
RUN hugo version
COPY hugo .
RUN hugo

FROM debian AS blog
WORKDIR /blog
COPY --from=build-server /build-server/build/server .
COPY --from=build-hugo /build-hugo/public ./public
ENTRYPOINT [ "./server" ]
