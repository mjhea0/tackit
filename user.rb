require 'net/http'
require 'uri'
require 'json'


module 2Gist
  class User
    
    def initialize(user, pass)
      @user = user
      @pass = pass
    
    def has_token?
      Token.find_token(@user, @pass)
    end
    
    def connect
      uri = URI.parse("https://api.github.com/authorizations")
      http = Net::HTTP.new(uri.hostname, uri.port)
      http.use_ssl = true
      request = Net::HTTP::Post.new(uri.path)
      request.basic_auth @user, @pass
      request.body = {"scopes" => "gist", "note" => "2gist"}.to_json
      response = http.request(request)
    end
  end
end