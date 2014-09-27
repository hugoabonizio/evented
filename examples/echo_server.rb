require File.dirname(__FILE__) + "/../lib/evented.rb"

server = Server.new('0.0.0.0', 8080)
server.on(:accept) do |stream|
  puts 'aceito'
end
server.start