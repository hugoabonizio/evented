require 'spec_helper'

describe Server do
  it "should call Evented constructor" do
    server = Server.new('0.0.0.0', 3001)
    server.callbacks.should_not be_nil
  end
end