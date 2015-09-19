require 'connection_pool'
Redis::Objects.redis = ConnectionPool.new(size: 5, timeout: 5) { Redis::Namespace.new("rsp_#{Rails.env.downcase}", :redis => Redis.new(:url => (ENV["REDIS_URL"]))) }