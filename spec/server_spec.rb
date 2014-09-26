require 'spec_helper'

describe Server do
  it "should call Evented constructor" do
    server = Server.new('0.0.0.0', 3001)
    expect(server.callbacks).to be_a Hash
    #server.callbacks.should_not be_nil
  end
  
  it "should accept new connections" do
    server = Server.new('0.0.0.0', 3002)
    control = 10
    server.on(:connect) do |_|
      control = 123
    end
    Thread.new { server.start }
    sleep(0.1)
    socket = TCPSocket.new('localhost', 3002)
    sleep(0.1)
    expect(control).to eql(123)
    
    server.stop
    
  end
end