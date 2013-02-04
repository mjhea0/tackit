require 'docopt'
require 'pp'
require 'highline/import'


doc = <<DOCOPT

Usage:
  #{__FILE__} create <file> [<file>...]
  #{__FILE__} list
DOCOPT


module Tackit
  PREFIX = File.dirname(__FILE__)
  ROOT = File.expand_path('../', __FILE__)
  
  require File.join(ROOT, 'tackit/version.rb')
  require File.join(ROOT, 'tackit/user.rb')
  require File.join(ROOT, 'tackit/token.rb')
  require File.join(ROOT, 'tackit/gist.rb')
  
  class Tackit
    
    def initialize
      @user = nil
    end

    def list
      unless @user
        token = connect()
      end
      Gist.list_gist(token)
    end

    def create(files)
      unless @user
        token = connect()
      end
      Gist.create_gist(token, files)
    end

    def connect
      user = ask 'Github Username: '
      pass = ask 'Password: '
       @user = User.new(user, pass)
      unless @user.has_token?
        token = @user.get_auth_token
      else
        @user.has_token?
      end
    end
    
  end
end

begin
  pp Docopt::docopt(doc)
  args = Docopt::docopt(doc)
  tackit = Tackit::Tackit.new
  if(args['create'])
    tackit.create(args['<file>'])
  else
    tackit.list()
  end
rescue Docopt::Exit => e
  puts e.message
end

