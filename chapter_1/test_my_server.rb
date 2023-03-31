require 'net/http' require_relative './my_server_fn'

puts "Test server_fn"

server_thread = Thread.new do
  puts "Thread 1. Init server"
  start_server
end

sleep 2

request_thread = Thread.new do
  puts "Thread 2. Curl"
  client = TCPSocket.new('localhost', 4321)

  puts client.read
    response = client.read
    puts "Response from server: #{response}"
    client.close 
end

sleep 1
server_thread.join
request_thread.join
