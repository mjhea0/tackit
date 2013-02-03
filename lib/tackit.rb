require 'docopt'
require 'pp'


doc = <<DOCOPT

Usage:
  #{__FILE__} upload <file> [<file>...]
  #{__FILE__} connect <username> <password>
  #{__FILE__} list
DOCOPT


module Tackit
  ROOT = File.expand_path('../', __FILE__)
  
  require 'tackit/version.rb'
  require 'tackit/user.rb'
  require 'tackit/token.rb'
  require 'tackit/gist.rb'
  
  class Tackit
  
    def initialize
    end

    def list
      @gist
    end

    def create(file)
      @gist.create_gist()
    end

    def connect(user, pass)
      @user = User.new(user, pass)
      unless @user.has_token?
        @user.get_auth
      end
    end
    
  end
end

begin
  pp Docopt::docopt(doc)
  '''
  args = Docopt::docopt(doc)
  if(args["username"])
    Tackit::Tackit.connect(args["username"], args["password"])
  elsif(args["file"])
    Tackit::Tackit.create(args["file"])
  else
    Tackit::Tackit.list()
    '''
rescue Docopt::Exit => e
  puts e.message
end

