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