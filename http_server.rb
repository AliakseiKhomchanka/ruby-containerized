require 'socket'

puts "Starting Ruby TCP Server on port 80..."

server = TCPServer.new('0.0.0.0', 80)

loop do
  client = server.accept
  puts "Client connected: #{client.peeraddr.inspect}"

  request = client.readpartial(2048)
  method, path, version = request.lines[0].split
  puts "Received request: #{method} #{path} #{version}"

  if path == "/healthcheck"
    puts "Health check, responding..."
    client.write("OK")
  else
    puts "Not health check, responding..."
    client.write("Well, hello there!")
  end

  client.close
  puts "Client disconnected"
end

