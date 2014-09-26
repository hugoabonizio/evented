require 'socket'

sock = TCPSocket.new('localhost', 8080)
sock.send 'haha', 0

