require File.dirname(__FILE__) + "/../lib/evented.rb"

server = Server.new('0.0.0.0', 8080)
server.on(:accept) do |stream| # callback when accept a new connection
  response = "Lorem ipsum"
  stream.send(response) do # callback after send
    stream.close
  end
end
server.start