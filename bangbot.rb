require "socket"

server = "irc.bitmakerlabs.com"
port = "6667"
nick = "BangBot"
channel = "#cohort5"
greeting_prefix = "privmsg #{channel} :"
greetings = ["hello", "hi", "hola", "yo", "wazup", "guten tag", "howdy", "salutations", "who the hell are you?"]

irc_server = TCPSocket.open(server, port)

irc_server.puts "USER bhellobot 0 * BHelloBot"
irc_server.puts "NICK #{nick}"
irc_server.puts "JOIN #{channel}"
irc_server.puts "PRIVMSG #{channel} Bang"

# Bang bot replies with Bang every time someone sends a message with an exclaimation mark
until irc_server.eof? do
  msg = irc_server.gets.downcase
  puts msg

  exclaim = msg.split(//).reject { |c| c != "!" }

  if exclaim.length > 1
    response = "BANG"
  	irc_server.puts "PRIVMSG #{channel} :#{response}"
  end
end


