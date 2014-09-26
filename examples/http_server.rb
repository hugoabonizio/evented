require File.dirname(__FILE__) + "/../lib/evented.rb"

server = Server.new('0.0.0.0', 8080)
server.on(:connect) do |sock|
  begin
    puts "connected #{sock}"
    sock.gets
    sock << "HTTP/1.1 200 OK\r\n" +
            "Content-Type: text/html\r\n" +
            "Content-Length: #{"<h1>lol</h1>".bytesize}\r\n" +
            "Connection: close\r\n\r\n"
    sock << "<h1>lol</h1>"
    sock.close
  rescue Errno::EPIPE
    # in case the connection closes before
    # the ende (Ex: if you're using ApacheBench)
  end
end

server.start