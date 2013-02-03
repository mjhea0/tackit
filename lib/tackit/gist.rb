require 'net/http'
require 'uri'
require 'json'

module Tackit
  class Gist
    
    def authorize(user, pass)
      uri = URI.parse("https://api.github.com/authorizations")
      http = Net::HTTP.new(uri.hostname, uri.port)
      http.use_ssl = true
      request = Net::HTTP::Post.new(uri.path)
      request.basic_auth user, pass
      request.body = {"scopes" => "gist", "note" => "2gist"}.to_json
      response = http.request(request)
      res_hash = JSON.parse(response.body)
      token = res_hash['token']
      token      
    end
    
    def list_gist(token)
    end
    
    def post_gist(token)
    end
    
    def get_gist(token)
    end
    
  end
end
