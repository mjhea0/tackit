require 'net/http'
require 'uri'
require 'json'

module Tackit
  class Gist
    
    def self.authorize(user, pass)
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
    
    def self.list_gist(token)
      uri = URI("https://api.github.com/gists?access_token=#{token}")
      request = Net::HTTP::Get.new(uri.request_uri)
      response = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => true) do |http|
        http.request(request)
      end
      res_hash = JSON.parse(response.body)
      if(res_hash.length == 1 && res_hash['message'])
        puts "Token expired. Remove yaml file"
        
      else
        res_hash.each do |gist|
          puts "\e[32m Id: #{gist['id'].to_s}\e[m"
          puts "\e[36m Desc: #{gist['description']}\e[m"
          puts "\e[34m URL: #{gist['html_url']}\e[m"
        end
        puts "#{res_hash.length} total gists"
      end
    end
    
    def self.create_gist(token, files)
      uri = URI("https://api.github.com/gists")
      request = Net::HTTP::Post.new(uri.path)
      request.add_field "Authorization", "token #{token}"
      params = {
        "description" => '',
        "public" => true,
        "files" => {
          
        }
      }
      files.each do |f|
        file = File.open(f, 'r')
        params["files"][File.basename(f)] = { "content" => file.read }
      end
        
      request.body = params.to_json
      response = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => true) do |http|
        http.request(request)
      end
      
      res_hash = JSON.parse(response.body)
      if(res_hash.length == 1 && res_hash['message'])
        puts "Token expired. Remove yaml file"
      else
        res_hash.each do |gist|
          puts "\e[36m Desc: #{gist['desctiption']}\e[m"
          puts "\e[34m URL: #{gist['html_url']}\e[m"
        end
        puts "Gist successfully created"
      end 
    end
    
    def self.get_gist(token)
      #coming soon
    end
    
  end
end
