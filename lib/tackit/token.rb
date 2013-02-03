require 'yaml'
require 'date'
require 'digest/sha1'

module Tackit
  class Token
    
    def get_hash(pass)
      hash = Digest::SHA1.hexdigest pass
      hash
    end
    
    def find_token(user, pass)
      hash = get_hash(pass)
      yaml_obj = YAML.load(hash)
    end
    
    def save_token(user, pass, token)
      hash = get_hash(pass)
      cred = { 
        :user => user, 
        :pass => pass, 
        :token => token, 
        :date => Date.now 
      }
      File.open(hash, 'w') do |file|
        file.write(cred.to_yaml)
      end
    end
    
  end
end
