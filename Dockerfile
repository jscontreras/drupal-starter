FROM drupal

RUN apt-get update && \
    apt-get install -y default-mysql-client

