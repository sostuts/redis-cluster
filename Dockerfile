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
RUN wget http://cache.ruby-lang.org/pub/ruby/2.2/ruby-2.2.2.tar.gz  
RUN tar xzf /ruby-2.2.2.tar.gz && cd ruby-2.2.2 && ./configure --prefix=/usr/local/ruby-2.2.2 && make && make install

WORKDIR /

# gem
RUN /usr/local/ruby-2.2.2/bin/gem install redis

# 添加redis配置
ADD ./redis.conf /redis.conf

# 运行redis
CMD ["/redis-3.2.5/src/redis-server", "/redis.conf"]