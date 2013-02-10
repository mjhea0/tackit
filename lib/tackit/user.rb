module Tackit
  class User
    
    def initialize(user, pass)
      @user = user
      @pass = pass
      @token = Token.new.find_token(@user, @pass)
    end
    
    def has_token?
      @token
    end
    
    def get_auth_token
      if @token
         return @token
      else
         @token = Gist.authorize(@user, @pass)
         Token.new.save_token(@user, @pass, @token)
         return @token
      end
    end
  end
end
