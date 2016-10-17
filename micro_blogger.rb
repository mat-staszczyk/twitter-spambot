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

  def run
    puts "Welcome to the JSL Twitter Client!"
  end

end
