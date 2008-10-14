class Slice
  include DataMapper::Resource
  
  ### API Call Reference
  
  GITHUB_QUERY = "http://github.com/api/v1/json/search/merb-slice"
  
  ### Properties
  
  property :id, Serial
  property :name, String
  property :source, String
  property :user_id, Integer
  property :last_commit_at, DateTime
  property :description, Text
  property :created_at, DateTime
  property :updated_at, DateTime
  
  ### Associations
  
  has n, :comments
  belongs_to :user
  
  ### Methods
  
  # ...
  
  ### Class Methods
  
  class << self
    
    def search
      # HTTP request with GITHUB_QUERY, parsing the JSON
      # updating or creating (or disabling) slices as appropriate
    end
    
  end
  
end
