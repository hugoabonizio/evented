require 'spec_helper'

describe Evented do
  it "should add event" do
    events = Evented.new
    events.callbacks.size.should eq(0)
    events.on(:teste) do
      'foo'
    end
    events.callbacks.size.should eq(1)
  end
  
  it "should call callback" do
    events = Evented.new
    control = 10
    events.on(:callback_event) do
      control += 10
    end
    events.emit(:callback_event)
    control.should eq(20)
  end
end