FROM dclong/jupyterlab

ARG spark=spark-2.1.0-bin-hadoop2.7

RUN apt-get update \
    && apt-get install -y \
        wget \
        scala \
    && wget http://d3kbcqa49mib13.cloudfront.net/$spark.tgz -O /$spark.tgz \
    && tar -zxvf /$spark.tgz -C /opt/ \
    && rm /$spark.tgz

COPY toree-0.2.0.dev1.tar.gz /
RUN pip3 install /toree-0.2.0.dev1.tar.gz \
    && jupyter toree install --spark_home=/opt/$spark/ \
    && rm /toree-0.2.0.dev1.tar.gz 

