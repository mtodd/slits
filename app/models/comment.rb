class Comment
  include DataMapper::Resource
  
  ### Properties
  
  property :id, Serial
  property :user_id, Integer
  property :slice_id, Integer
  property :body, Text
  property :created_at, DateTime
  property :updated_at, DateTime
  
  ### Associations
  
  belongs_to :user
  belongs_to :slice
  
end
