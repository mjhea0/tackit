require 'docopt'
require 'pp'
require 'net/http'
require 'uri'
require 'json'


doc = <<DOCOPT

Usage:
  #{__FILE__} <file> [<file>]
  #{__FILE__} --config <username> <password>

DOCOPT

begin
  pp Docopt::docopt(doc)
rescue Docopt::Exit => e
  puts e.message
end


uri = URI.parse("https://api.github.com/authorizations")
http = Net::HTTP.new(uri.hostname, uri.port)
http.use_ssl = true
request = Net::HTTP::Post.new(uri.path)
request.basic_auth 'ammoses89', ''
request.body = {"scopes" => "gist", "note" => "2gist"}.to_json


response = http.request(request)

puts response.body
