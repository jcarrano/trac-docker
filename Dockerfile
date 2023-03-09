FROM docker.io/alpine:3.13

RUN apk add --update \
    py3-pip subversion git \
    && rm -rf /var/cache/apk/* \
    && pip install https://download.edgewall.org/trac/Trac-1.5.4-py3-none-any.whl svn+https://trac-hacks.org/svn/iniadminplugin/0.11

COPY htpasswd.py /htpasswd.py
COPY entry.sh /entry.sh
ENTRYPOINT ["/entry.sh"]
