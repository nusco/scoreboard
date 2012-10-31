require 'bundler/setup'
require 'sinatra'

SCOREboard = {}

get '/' do
  getMarkup
end

post '/score' do
	team = params[:teamName]
	score = params[:score]
	SCOREboard[team]=score
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