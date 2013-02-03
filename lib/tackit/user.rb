module Tackit
  class User
    
    def initialize(user, pass)
      @user = user
      @pass = pass
      @token = Token.find_token(@user, @pass)
    
    def has_token?
      @token
    end
    
    def get_auth_token
      @token = Gist.authorize(@user, @pass)
      Token.save_token(@user, @pass, @token)
    end
  end
end