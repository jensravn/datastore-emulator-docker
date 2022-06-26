FROM ubuntu:latest

RUN apt-get update && apt-get install apt-transport-https curl gnupg ca-certificates -y

RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" \
    | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list \
    && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg \
    | apt-key --keyring /usr/share/keyrings/cloud.google.gpg  add - \
    && apt-get update -y \
    && apt-get install google-cloud-sdk google-cloud-sdk-datastore-emulator google-cloud-sdk-pubsub-emulator -y

# Volume to persist data
VOLUME /opt/data

COPY start-datastore .
# COPY start-pubsub .

EXPOSE 9091

# Start datastore by default; users can specify other entrypoints.
CMD ["./start-datastore"]