# This is a default user class used to activate merb-auth.  Feel free to change from a User to 
# Some other class, or to remove it altogether.  If removed, merb-auth may not work by default.
#
# Don't forget that by default the salted_user mixin is used from merb-more
# You'll need to setup your db as per the salted_user mixin, and you'll need
# To use :password, and :password_confirmation when creating a user
#
# see config/merb-auth/setup.rb to see how to disable the salted_user mixin
# 
# You will need to setup your database and create a user.
class User
  include DataMapper::Resource
  
  ### Properties
  
  property :id, Serial
  property :username, String
  property :created_at, DateTime
  property :updated_at, DateTime
  
  ### Associations
  
  has n, :comments
  has n, :slices
  has n, :taggings
  has n, :tags, :through => :taggings
  
end
