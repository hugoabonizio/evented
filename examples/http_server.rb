#require 'evented'
require File.dirname(__FILE__) + "/../lib/evented.rb"

server = Evented::Server.new('0.0.0.0', 8080)
server.on(:accept) do |stream|
  begin
    #puts "connected #{stream}"
    sleep 0.1
    data = "HTTP/1.1 200 OK\r\n" +
           "Content-Type: text/html\r\n" +
           "Content-Length: #{"<h1>lol</h1>".bytesize}\r\n" +
           "Connection: close\r\n\r\n" +
           "<h1>lol</h1>"
    
    stream.gets
    stream.send(data) do
      stream.close
    end
    
  rescue Errno::EPIPE
    # in case the connection closes before
    # the ende (Ex: if you're using ApacheBench)
  end
end

server.start