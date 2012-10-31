require 'bundler/setup'
require 'sinatra'
require 'json'

configure do
  require 'redis'
  
  if ENV["REDISTOGO_URL"]
    uri = URI.parse(ENV["REDISTOGO_URL"])
    REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
  end
  
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
  markup
end

get 'score' do
	markup
end

post '/score' do
	team = params[:teamName]
	score = params[:score]
	scoreboard = fetch_score_board
	scoreboard[team]=score
	save(scoreboard)
	markup()
end

def markup()
	return form + score
end	

def form()
	return '<html>
  	<head><title>Score board</title></head>
  	<body>
  		<h1>Hell o Team!</h1>
  		<div>
  			<form action="score" method="POST">
  				<label for="teamName">Team:</label>
  				<input type="text" name="teamName" value="" /></br>
  				<label for="score">Score:</label>
  				<input type="text" name="score" value="" /></br>
  				<input type="submit" value="hit me baby!"/>
  			</form>
  		</div>

  	</body>
  	</html>'
end

def score()
	scoreboard = fetch_score_board
	table = "<table>"
	scoreboard.each do |key,value|
		table << "<tr><td>#{key}</td><td>#{value}</td></tr>"
	end	
	table << "</table>"
end

def fetch_score_board
	redis_data = REDIS.get("scoreboard")
	return JSON.parse(redis_data) if redis_data
	return {}
end	

def save(scoreboard)
	REDIS.set("scoreboard",scoreboard.to_json)
end	
