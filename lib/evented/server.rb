require 'socket'

class Server < Evented
  
  def initialize(host, port)
    super()
    @io = TCPServer.new(host, port)
    streams << self
    on(:accept) do |sock|
      emit(:connect, sock)
    end
  end
  
  def to_io
    @io
  end
  
  def handle_read
    sock = @io.accept_nonblock
    emit(:accept, sock)
    rescue IO::WaitReadable
  end
  
  def handle_write
    
  end
  
end