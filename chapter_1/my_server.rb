require 'socket'

RESP = <<TEXT
HTTP/1.1 200 OK
Content/Type: text/plain

Hello world!
TEXT

server = TCPServer.new 4321
loop do
  puts "meow"
  client = server.accept
  puts "Connected.."
  puts client.gets.inspect
  client.write RESP
  client.close
end
