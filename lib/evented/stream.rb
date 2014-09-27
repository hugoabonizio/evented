class Stream < Evented
  attr_accessor :_callbacks, :buffer
  
  def initialize(io)
    @io = io
    @buffer = ''
    streams << self
    @_callbacks ||= Hash.new { |hash, key| hash[key] = Array.new }
  end
  
  def to_io
    @io
  end
  
  def on(event, &block)
    @_callbacks[event] << block
  end
    
  def emit(event, *args)
    @_callbacks[event].each do |callback|
      callback.call(*args)
    end
  end
  
  def handle_read
    # handle data
  end
  
  def handle_write
    return if @buffer.empty?
    @io.write_nonblock(@buffer)
    @buffer = ''
    emit(:sent)
    rescue IO::WaitWritable
  end
  
  def send(chunk, &block)
    @buffer << chunk
    on(:sent, &block)
  end
  
  def close
    @io.close
    streams.delete(self)
  end
  
  def gets
    @io.gets
  end
  
end