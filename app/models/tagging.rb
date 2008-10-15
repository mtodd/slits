class Tagging
  include DataMapper::Resource
  
  ### Properties
  
  property :id, Serial
  property :tag_id, Integer
  property :slice_id, Integer
  property :user_id, Integer
  
  ### Associations
  
  belongs_to :tag
  belongs_to :slice
  belongs_to :user
  
end
