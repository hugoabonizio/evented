require 'threading'

module Evented
  class Evented

    def initialize
      @@_callbacks ||= Hash.new { |hash, key| hash[key] = Array.new }
      @@_streams = []
      @@_pool = Pool.new(threads: 16)
    end

    def callbacks
      @@_callbacks
    end

    def streams
      @@_streams
    end

    def on(event, &block)
      @@_callbacks[event] << block
    end

    def emit(event, *args)
      @@_callbacks[event].each do |callback|
        @@_pool << Proc.new { callback.call(*args) }
        #callback.call(*args)
      end
    end

    def start
      @running = true
      while @running
        tick
      end
    end

    def start_threaded
      Thread.new { start }
    end

    def stop
      @running = false
    end

    def tick
      r, w = IO.select(@@_streams, @@_streams)
      r.each do |stream|
        stream.handle_read
      end
      
      w.each do |stream|
        stream.handle_write
      end
      
      # old way (mainted for learning reasons)
      # and to show how noob I am
      #
      # @@_streams.each do |stream|
      #    stream.handle_read
      #    stream.handle_write
      #  end
      
    rescue EOFError, IOError, Errno::ECONNRESET
      @@_streams.each do |s|
        if s.to_io.closed?
          s.emit(:close)
          @@_streams.delete(s)
        end
      end
    end

  end
end