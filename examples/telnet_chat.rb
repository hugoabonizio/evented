require 'evented'

# It's a very simple example of a telnet chat that
# broadcasts a message to all clients connected, using
# the concepts of the evented-server and streams

server = Server.new('0.0.0.0', 9090)
puts 'Listening on 9090...'
users = []
server.on(:accept) do |stream|
  users << stream
  stream.on(:data) do |data|
    users.each { |user| user.send(data) unless user == stream }
  end
end
server.start