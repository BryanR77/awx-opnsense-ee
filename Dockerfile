ARG IMAGE=
FROM $IMAGE

RUN yum install -y python3-pip && pip3 install --upgrade pip && pip3 install --break-system-packages ansible-builder

WORKDIR /build

COPY requirements.yml requirements.yml
COPY execution-environment.yml execution-environment.yml

ENTRYPOINT ["ansible-builder", "build"]
CMD [ "-t", "ansible-opnsense-ee:latest"]