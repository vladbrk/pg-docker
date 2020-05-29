FROM ubuntu:20.10
RUN apt-get update

RUN apt install -y ssh

#Install postgresql
ARG DEBIAN_FRONTEND=noninteractive
RUN apt install -y postgresql-12

#Init postgresql
WORKDIR /etc/postgresql/12/main/

## Make role postgres 'trust' for changing password
RUN sed 's/^local   all             postgres.*/local   all             postgres                                trust/' pg_hba.conf > pg_hba.conf.temp
RUN rm pg_hba.conf
RUN mv pg_hba.conf.temp pg_hba.conf

## Change password
RUN service postgresql start \\
    && service postgresql status \\
    && echo "ALTER USER postgres password 'postgres';" | psql postgres postgres

## Open access to host remotely and make role postgres 'md5' back
RUN echo 'host    all             all             0.0.0.0/0               md5' >> pg_hba.conf
RUN sed 's/^local   all             postgres.*/local   all             postgres                                md5/' pg_hba.conf > pg_hba.conf.temp
RUN rm pg_hba.conf
RUN mv pg_hba.conf.temp pg_hba.conf
RUN sed "s/^#listen_addresses.*/listen_addresses = '*'/" postgresql.conf > postgresql.conf.temp
RUN rm postgresql.conf
RUN mv postgresql.conf.temp postgresql.conf

# Add user admin
RUN adduser --disabled-password --gecos "" admin
RUN echo "admin:123"|chpasswd

EXPOSE 5432
EXPOSE 22

CMD service postgresql start
CMD service ssh start