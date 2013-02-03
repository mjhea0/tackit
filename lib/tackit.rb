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
  
  puts ROOT
  
  require File.join(ROOT, 'tackit/version.rb')
  require File.join(ROOT, '/tackit/user.rb')
  require File.join(ROOT, '/tackit/token.rb')
  require File.join(ROOT, '/tackit/gist.rb')
  
  class Tackit
    
    def initialize
      @user = nil
      @gist = nil
    end

    def list
      unless @user
        connect()
      end
      @gist
    end

    def create(file)
      unless @user
        connect()
      end
      @gist.create_gist()
    end

    def connect
      user = ask 'Github Username: '
      pass = ask 'Password: '
       @user = User.new(user, pass)
      unless @user.has_token?
        @user.get_auth
      end
    end
    
  end
end

begin
  pp Docopt::docopt(doc)
  args = Docopt::docopt(doc)
  tackit = Tackit::Tackit.new
  if(args['create'])
    tackit.create(args['file'])
  else
    tackit.list()
  end
rescue Docopt::Exit => e
  puts e.message
end

