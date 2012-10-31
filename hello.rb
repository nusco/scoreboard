require 'bundler/setup'
require 'sinatra'
require 'json'

SCOREboard = {}

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
  getMarkup
end

get 'score' do
	getMarkup
end

post '/score' do
	team = params[:teamName]
	score = params[:score]
	scoreboard = JSON.parse(REDIS.get("scoreboard"))
	SCOREboard[team]=score
	REDIS.set("scoreboard",SCOREboard.to_json)
	getMarkup()
end

def getMarkup()
	return getForm + getScore
end	

def getForm()

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

def getScore()
	table = "<table>"
	SCOREboard.each do |key,value|
		table << "<tr><td>#{key}</td><td>#{value}</td></tr>"
	end	
	table << "</table>"
end