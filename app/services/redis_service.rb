class RedisService

  def connection
    connection ||= Redis.new(url: ENV['REDIS_URL'])
  end

  def exists(key)
    connection.exists(key)
  rescue Redis::CannotConnectError
    false
  end

  def get(key)
    connection.get(key)
  rescue
    false
  end

  def set(key, value)
    connection.set(key, value)
    connection.expire(key, 300) # Cache value for 5 minutes
    value
  rescue
    value
  end
end
