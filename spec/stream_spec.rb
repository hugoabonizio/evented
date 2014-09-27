require 'spec_helper'

describe Stream do
  it "should initiate properly" do
    stream = Stream.new(Object.new)
    expect(stream._callbacks).to be_a Hash
    expect(stream.buffer).to eql('')
  end
  
  it "should increment buffer" do
    stream = Stream.new(Object.new)
    stream.send("test data")
    expect(stream.buffer.size).to eql("test data".size)
  end
  
  it "should close and self delete" do
    stream = Stream.new(File.new(__FILE__))
    expect(stream.streams).to include(stream)
    stream.close
    expect(stream.streams).not_to include(stream)
  end
  
  it "should emit events" do
    stream = Stream.new(File.new(__FILE__))
    control = 5
    stream.on(:test) do
      control = 55
    end
    stream.emit(:test)
    expect(control).to eql(55)
  end
  
  it "should emit events only internally" do
    stream = Stream.new(File.new(__FILE__))
    stream2 = Stream.new(File.new(__FILE__))
    control = 5
    stream.on(:test) do
      control = 55
    end
    stream2.emit(:test)
    expect(control).to eql(5)
  end

  it "should close stream if the socket has closed" do
    port = 7000 + rand(1000)
    server = Server.new('localhost', port)
    control = nil
    server.on(:accept) do |stream|
      control = stream
      sleep(1)
      stream.send('teste')
    end
    server.start_threaded
    sock = TCPSocket.new('localhost', port)
    sleep(0.1)
    expect(server.streams).to include(control)
    sock.close
    # have to finish, it's still not deleting closed connections
  end
  
  # TODO
  # verify the read and write data
end