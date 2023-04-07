require_relative 'lib/blue_eyes'


server = TCPServer.new 4321

loop do
  client = server.accept
  req = BlueEyes::Request.new(client)
  puts "REQUEST"
  puts req
  resp = BlueEyes::Response.new("Hello from ruby")
  
  puts "resp"
  puts resp
  client.write resp.to_s
  client.close
rescue
  puts "Error.. #{$!.inspect}"
end
