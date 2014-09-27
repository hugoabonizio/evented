# Evented
----------

__Evented__ is a simple event-driven IO gem written in pure Ruby. Here's a example of an evented server that waits for connections and send a response.

```ruby
require 'evented'
server = Server.new('0.0.0.0', 8080)
server.on(:accept) do |stream| # callback when accept a new connection
  response = "Lorem ipsum"
  stream.send(response) do # callback after send
    stream.close
  end
end
server.start
```

It's designed for take advantages of the event-driven flow, when it's necessary. For example, when you want to send a response to client when it sends you a message, using callbacks, like:

```ruby
require 'evented'
server = Server.new('0.0.0.0', 8081) # echo server
server.on(:accept) do |stream|
  stream.on(:data) do |data|
    stream.send(data) do
      stream.close
    end
  end
end
server.start
```