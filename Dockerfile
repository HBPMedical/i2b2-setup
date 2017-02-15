FROM python:3.6.0

MAINTAINER mirco.nasuti@chuv.ch


########################################################################################################################
# Install Alembic and Psycopg2
########################################################################################################################

RUN pip install --no-cache-dir alembic==0.8.10 psycopg2==2.6.2


########################################################################################################################
# Install Dockerize
########################################################################################################################

ENV DOCKERIZE_VERSION 'v0.3.0'
RUN wget "https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz" \
    && tar -C "/usr/local/bin" -xzvf "dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz" \
    && rm "dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz"


########################################################################################################################
# Copy project files
########################################################################################################################

COPY alembic.ini.tmpl /alembic.ini.tmpl
COPY i2b2_schema.py /i2b2_schema.py
COPY db_migrations/ /db_migrations/


########################################################################################################################
# Setup entrypoint and cmd
########################################################################################################################

WORKDIR /
ENTRYPOINT ["dockerize", "-template", "/alembic.ini.tmpl:/alembic.ini", "alembic"]
CMD ["help"]
