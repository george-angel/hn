FROM golang:alpine AS build
WORKDIR /go/src/app
COPY . /go/src/app/
RUN apk --no-cache add git &&\
 go get ./... &&\
 CGO_ENABLED=0 go build -o /hn .

FROM alpine:3.8
RUN apk add --no-cache ca-certificates
COPY --from=build /hn /hn
CMD [ "/hn" ]
