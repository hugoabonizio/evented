class Evented
  
  def initialize
    @@_callbacks ||= Hash.new { |hash, key| hash[key] = Array.new }
    @@_streams = []
  end
  
  def callbacks
    @@_callbacks
  end
  
  def on(event, &block)
    @@_callbacks[event] << block
  end
    
  def emit(event, *args)
    @@_callbacks[event].each do |callback|
      callback.call(*args)
    end
  end
  
  def start
    @running = true
    while @running
      tick
    end
  end
  
  def tick
    @@_streams.each do |stream|
      stream.handle_read
      stream.handle_write
    end
  end
  
end