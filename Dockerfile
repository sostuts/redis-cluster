FROM centos:6.7

RUN yum install -y \
    tar \
    gcc \
    make \
    wget \
    zlib-devel \
    openssl-devel


# 下载安装redis
RUN wget http://download.redis.io/releases/redis-3.2.5.tar.gz 
RUN tar xzf redis-3.2.5.tar.gz && cd redis-3.2.5 && make MALLOC=libc && make install
RUN cp /redis-3.2.5/src/redis-trib.rb /usr/local/bin

WORKDIR /

# 下载安装gem
RUN wget https://cache.ruby-lang.org/pub/ruby/2.3/ruby-2.3.1.tar.gz
RUN tar xzf /ruby-2.3.1.tar.gz && cd ruby-2.3.1 && ./configure --prefix=/usr/local/ruby-2.3.1 && make && make install
RUN cp /usr/local/ruby-2.3.1/bin/* /usr/local/bin/

WORKDIR /

# gem
RUN /usr/local/ruby-2.3.1/bin/gem install redis

# 添加redis配置
COPY ./redis.conf /redis.conf
COPY ./start.sh /start.sh
RUN chmod a+x /start.sh


# 运行redis
CMD ["/start.sh"]