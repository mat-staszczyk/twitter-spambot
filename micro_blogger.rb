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

  def followers_list
    screen_names = []
    @client.followers.each do |follower|
      screen_names << @client.user(follower).screen_name
    end
    screen_names
  end

  def spam_my_followers(message)
    followers_list.each do |follower|
      dm(follower, message)
    end
  end

  def dm(target, message)
    puts "Trying to send #{target} this message:"
    puts message
    screen_names = @client.followers.collect { |follower| @client.user(follower).screen_name }
    if screen_names.include? target
      message = "d @#{target} #{message}"
      tweet(message) 
    else
      puts "@#{target} is not following you!"
    end
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
        when 'spam' then spam_my_friends(parts[1..-1].join(" "))
        when 'q' then puts "Goodbye!"
        else
          puts "Sorry, I don't know how to #{command}"
      end
    end
  end

end
