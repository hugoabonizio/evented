require 'evented'

server = Server.new('0.0.0.0', 8081) # echo server
server.on(:accept) do |stream|
  stream.on(:data) do |data|
    stream.send(data) do
      stream.close
    end
  end
end
server.start