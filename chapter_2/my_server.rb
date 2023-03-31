require_relative 'lib/rebuilding_http'
include RHHTP 

server = TCPServer.new 4321

loop do 
  client = server.accept
  req = RHHTP.read_request(client)
  puts req
  client.write HELLO_WORLD_RESPONSE
  client.close
rescue 
  puts "Read error! Continuing. #{$!.inspect}"
end
