require 'jumpstart_auth'

class MicroBlogger
  attr_reader :client

  def initialize 
    puts "Initializing..."
    @client = JumpstartAuth.twitter
  end

  def tweet(message)
    if message.length <= 140
      @client.update(message)
    else
      puts "Your tweet is too long!"
    end
  end

  def dm(targer, message)
    puts "Trying to send #{tager} this message:"
    puts message
    message = "d @#{targer} #{message}"
    tweet(message)
  end

  def run
    puts "Welcome to the JSL Twitter Client!"
    
    command = ""
    while command != "q"
      printf "enter command: "
      parts = gets.chomp.split(" ")
      command = parts[0]
      case command
        when 't' then tweet(parts[1..-1].join(" ")) 
        when 'dm' then dm(parts[1], parts[2..-1].join(" "))
        when 'q' then puts "Goodbye!"
        else
          puts "Sorry, I don't know how to #{command}"
      end
    end
  end

end
