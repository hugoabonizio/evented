require 'spec_helper'

describe Evented::Server do
  it "should call Evented constructor" do
    server = Evented::Server.new('0.0.0.0', 3001)
    expect(server.callbacks).to be_a Hash
    #server.callbacks.should_not be_nil
  end
  
  it "should accept new connections" do
    server = Evented::Server.new('0.0.0.0', 3002)
    control = 10
    server.on(:accept) do |_|
      control = 123
    end
    server.start_threaded
    sleep(0.1)
    socket = TCPSocket.new('localhost', 3002)
    sleep(0.1)
    expect(control).to eql(123)
    
    server.stop
    
  end
end