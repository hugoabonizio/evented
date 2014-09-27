require 'spec_helper'

describe "Integration between parts" do
  after :each do
    @server.to_io.close
  end
  
  it "server should receive chunks" do
    @control = ''
    port = 15000 + rand(1000)
    @server = Server.new('localhost', port)
    @server.on(:accept) do |stream|
      stream.on(:data) do |data|
        @control = data
      end
    end
    @server.start_threaded
    
    sock = TCPSocket.new('localhost', port)
    sock.send('some data', 0)
    sleep(0.1)
    expect(@control).to eql('some data')
  end
  
  it "server should send chunks" do
    @control = ''
    port = 15000 + rand(1000)
    @server = Server.new('localhost', port)
    @server.on(:accept) do |stream|
      stream.send('sending')
    end
    @server.start_threaded
    
    sock = TCPSocket.new('localhost', port)
    received, _ = sock.recvfrom('sending'.size)
    expect(received).to eql('sending')
    
  end
end