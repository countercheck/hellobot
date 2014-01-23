require "socket"

server = "irc.bitmakerlabs.com"
port = "6667"
nick = "StealthBot"
channel = "#cohort5"
greeting_prefix = "privmsg #{channel} :"
greetings = ["hello", "hi", "hola", "yo", "wazup", "guten tag", "howdy", "salutations", "who the hell are you?"]

irc_server = TCPSocket.open(server, port)

irc_server.puts "USER bhellobot 0 * BHelloBot"
irc_server.puts "NICK #{nick}"
irc_server.puts "JOIN #{channel}"
irc_server.puts "PRIVMSG #{channel} I'm not here"

# StealthBot detects whenever anyone logs off the channel, and assumes their nickname
until irc_server.eof? do
  msg = irc_server.gets.downcase
  puts msg

  leave = false
  leave = true if msg.include?("quit :")

  if leave
    split_msg = msg.split("!")
    new_name = split_msg[0][1..-1]
    irc_server.puts "NICK #{new_name}"
    response = "I just stole #{new_name}'s name!"
    irc_server.puts "PRIVMSG #{channel} :#{response}"
  end
end