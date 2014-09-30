require 'evented'

port = 11000 + rand(1000)
puts "Listening on #{port}..."
server = Server.new('0.0.0.0', port)
server.on(:accept) do |stream| # callback when accept a new connection
  response = "Lorem ipsum"
  stream.send(response) do # callback after send
    stream.close
  end
end
server.start