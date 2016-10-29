#!/bin/sh
echo $auth | sed -i "s/password => nil/password => \"$auth\"/g" /usr/local/ruby-2.3.1/lib/ruby/gems/2.3.0/gems/redis-3.3.1/lib/redis/client.rb;
/redis-3.2.5/src/redis-server /redis.conf;