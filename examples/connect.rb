require 'socket'

#sock = TCPSocket.new('localhost', 8080)
#sock.send 'haha', 0

require File.dirname(__FILE__) + "/../lib/evented.rb"

server = Server.new('0.0.0.0', 3002)
control = 10
server.on(:connect) do |_|
  control += 10
end
Thread.new { server.start }

socket = TCPSocket.new('localhost', 3002)
sleep(0.1)
puts control

server.stop

