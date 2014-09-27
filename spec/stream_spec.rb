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
  
  # TODO
  # verify the read and write data
end