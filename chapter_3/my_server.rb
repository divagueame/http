require_relative 'lib/rebuilding_http'
include RHTTP 

server = TCPServer.new 4321

loop do 
  client = server.accept
  req = RHTTP.get_request(client)
  puts req.inspect
  resp = RHTTP::Response.new("Meowme", headers: { 'Framework': 'ChikiPin' })
  client.write resp.to_s 
  client.close
rescue 
  puts "Read error! Continuing. #{$!.inspect}"
end
