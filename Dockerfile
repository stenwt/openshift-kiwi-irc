FROM centos:7

# MAINTAINER Sten Turpin <sten@redhat.com>

ENV REPORT_STATS yes

LABEL io.k8s.description="Platform for building Kiwi IRC" \
      io.k8s.display-name="builder kiwi" \
      io.openshift.expose-services="7778:http" \
      io.openshift.tags="builder,kiwi"

RUN yum -y install epel-release && yum clean all

RUN yum -y install nodejs git && yum clean all

RUN git clone https://github.com/prawnsalad/KiwiIRC.git

WORKDIR KiwiIRC

RUN npm install

RUN sed 's/127.0.0.1\/32/10.0.0.0\/8/' config.example.js > config.js

RUN ./kiwi build 

EXPOSE 7778

CMD ["./kiwi", "-f" ]
