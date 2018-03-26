REDIS_POOL = ConnectionPool.new(size: 10, timeout: 5) { Redis.new(url: ENV['REDIS_URL']) }
