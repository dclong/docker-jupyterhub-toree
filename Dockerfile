FROM dclong/jupyterhub-jdk

ARG spark=spark-2.4.0
ARG spark_hdp=$spark-bin-hadoop2.7

RUN apt-get update \
    && apt-get install -y scala \
    && wget http://d3kbcqa49mib13.cloudfront.net/$spark_hdp.tgz -O /$spark_hdp.tgz \
    && wget http://us.mirrors.quenda.co/apache/spark/$spark/$spark_hdp.tgz -O /$spark_hdp.tgz \
    && tar -zxvf /$spark_hdp.tgz -C /opt/ \
    && rm /$spark_hdp.tgz

COPY scripts /scripts
RUN pip3 install /scripts/toree.tar.gz \
    && pip3 install --upgrade setuptools \
    && jupyter toree install --spark_home=/opt/$spark_hdp/ \
    && rm /scripts/toree.tar.gz 

