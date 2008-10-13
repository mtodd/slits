class Slice
  include DataMapper::Resource
  
  GITHUB_QUERY = "http://github.com/api/v1/json/search/merb-slice"
  
  class << self
    
    def search
      # HTTP request with GITHUB_QUERY, parsing the JSON
      # updating or creating (or disabling) slices as appropriate
    end
    
  end
  
end
