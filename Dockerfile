FROM alpine:3.3

RUN apk --no-cache add --update \
      py-pip \
      python \
      ca-certificates \
      openssl &&\
      update-ca-certificates &&\
    pip install --upgrade \
      pip \
      awscli

ENV KEY= SECRET= REGION= BUCKET= BUCKET_PATH=/ CRON_SCHEDULE="0 1 * * *" PARAMS= LOCAL_PATH="/data" HEALTHCHECK_URL=

VOLUME ["/data"]

ADD *.sh /
RUN chmod +x /*.sh

ENTRYPOINT ["/start.sh"]
CMD [""]
