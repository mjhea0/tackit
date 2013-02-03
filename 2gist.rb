require 'docopt'


doc = <<DOCOPT

Usage:
  #{__FILE__} <file> [<file>]
  #{__FILE__} --config <username> <password>

DOCOPT

module 2Gist
  
  class 2Gist
  
    def initialize
    end

    def list
      @gist
    end

    def create(file)
      @gist.create_gist()
    end

    def connect(user, pass)
      @user = User(user, pass)
      unless @user.has_token?
        @user.get_auth
      end

    end
    
  end

end

begin
  args = Docopt::docopt(doc)
  if(args['username'])
    2Gist::2Gist.connect(args['username'], args['password'])
  elsif(args['file'])
    2Gist::2Gist.create(args['file'])
    
rescue Docopt::Exit => e
  puts e.message
end

