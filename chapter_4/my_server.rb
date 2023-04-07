require_relative 'lib/rebuilding_http'
include RHTTP 

server = TCPServer.new 4321

loop do 
  client = server.accept
  req = RHTTP.get_request(client)
  puts req.inspect
# resp = RHTTP::Response.new("Meowme", headers: { 'Framework': 'ChikiPin', 'Time': 'Some time ago...' })
  resp = RHTTP::Response.new("Meowme")
  client.write resp.to_s 
  client.close
rescue 
  puts "Read error! Continuing. #{$!.inspect}"
  next
end
