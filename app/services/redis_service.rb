class RedisService
  def exists(key)
    REDIS_POOL.with do |connection|
      connection.exists(key)
    end
  rescue Redis::CannotConnectError
    false
  end

  def get(key)
    REDIS_POOL.with do |connection|
      connection.get(key)
    end
  rescue Redis::CannotConnectError
    nil
  end

  def set(key, value)
    REDIS_POOL.with do |connection|
      connection.set(key, value)
      connection.expire(key, 300) # Cache value for 5 minutes
      value
    end
  rescue Redis::CannotConnectError
    value
  end
end
