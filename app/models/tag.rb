class Tag
  include DataMapper::Resource
  
  ### Properties
  
  property :id, Serial
  property :name, String
  
  ### Associations
  
  has n, :taggings
  has n, :slices, :through => :taggings
  has n, :users, :through => :taggings
  
end
