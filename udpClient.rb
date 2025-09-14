require 'socket'

port_str = nil
ip_str = nil
data = nil
MAX_UDP_SIZE = 65507


if ARGV.empty?
  puts "IP and Port not provided"
  exit(0)
else
  ARGV.each_slice(2) do |flag, value|
    case flag
    when "-i"
      ip_str = value
    when "-p"
      port_str = value
    when "-f"
      data = value
    end
  end
end


if ip_str == nil or port_str == nil or data == nil
  puts "Please provide all the mandatory flags"
  exit(0)
end

server_address = ip_str
server_port = port_str.to_i
socket = UDPSocket.new

data_mut = File.read("#{data}")

offset = 0
while offset < data_mut.bytesize
  chunk = data_mut.byteslice(offset, MAX_UDP_SIZE)
  socket.send(chunk, 0, server_address, server_port)
  offset += chunk.bytesize
end
