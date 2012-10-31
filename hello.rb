require 'bundler/setup'
require 'sinatra'

configure do
  require 'redis'
  uri = URI.parse(ENV["REDISTOGO_URL"])
  REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
  begin
      REDIS.get("key")
  rescue
    puts
    puts "WARNING: Could not connect to redis - using an in-memory mock"
    puts
    require "mock_redis"
    REDIS = MockRedis.new
  end
end

get '/' do
  "Hello, world!"
end