FROM debian:buster-slim

ENV LANG C.UTF-8

RUN set -x; \
        apt-get update \
        && apt-get install -y --no-install-recommends \
               ca-certificates \
                wget \
                git \
                curl \
                dirmngr \
                fonts-noto-cjk \
                gcc \
                gnupg \
                libssl-dev \
                node-less \
                npm \
                python3-dev \
                python3-pip \
                python3-phonenumbers \
                python3-pyldap \
                python3-renderpm \
                python3-setuptools \
                python3-slugify \
                python3-watchdog \
                python3-gevent \
                libevent-dev \
                libxml2-dev \
                libxslt1-dev \
                libldap2-dev \
                libsasl2-dev \
                xz-utils \
                vim \
        && curl -o wkhtmltox.deb -sSL https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox_0.12.5-1.stretch_amd64.deb \
        && echo '7e35a63f9db14f93ec7feeb0fce76b30c08f2057 wkhtmltox.deb' | sha1sum -c - \
        && apt-get install -y --no-install-recommends ./wkhtmltox.deb \
        && rm -rf /var/lib/apt/lists/* wkhtmltox.deb

RUN apt-get update  \
        && apt-get install --no-install-recommends -y postgresql-client \
        && rm -f /etc/apt/sources.list.d/pgdg.list \
        && rm -rf /var/lib/apt/lists/*

RUN npm install -g rtlcss

WORKDIR /opt

COPY odoo.conf .

RUN git clone https://github.com/odoo/odoo.git \
        && pip3 install -r odoo/requirements.txt \
        && pip3 install psycopg2-binary

EXPOSE 8069

ENTRYPOINT ["odoo/odoo-bin", "-c", "odoo.conf"]
