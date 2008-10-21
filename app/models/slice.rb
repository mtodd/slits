require 'net/http'
require 'uri'
require 'json'

class Slice
  include DataMapper::Resource
  
  ### API Call Reference
  
  GITHUB_SEARCH = "http://github.com/api/v1/json/search/%s"
  GITHUB_REPOSITORY = "http://github.com/api/v1/json/%s/%s/commits/master"
  
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
  
  belongs_to :user
  has n, :comments
  has n, :taggings
  has n, :tags, :through => :taggings
  
  ### Methods
  
  # ...
  
  ### Class Methods
  
  class << self
    
    def search
      ### GET the repositories from GitHub
      search_address = GITHUB_SEARCH % ["merb-slice"]
      uri = URI.parse(search_address)
      request = Net::HTTP::Get.new(uri.path)
      repositories = Net::HTTP.start(uri.host, uri.port) do |http|
        Merb.logger.debug "Searching GitHub: #{search_address}"
        Mash.new(JSON.parse(http.request(request).body))[:repositories]
      end
      Merb.logger.debug "Found #{repositories.size} repositories"
      
      ### Parse response
      repositories.each do |repository|
        Merb.logger.debug "Processing repository #{repository[:name]}"
        Merb.logger.debug "#{repository.inspect}"
        
        ### establish a user if none exists
        unless user = User.first(:username => repository[:owner])
          user = User.new(:username => repository[:owner])
          user.save
        end
        
        ### retrieve latest commit for repo
        commits_address = GITHUB_REPOSITORY % [repository[:owner], repository[:name]]
        uri = URI.parse(commits_address)
        request = Net::HTTP::Get.new(uri.path)
        commit = Net::HTTP.start(uri.host, uri.port) do |http|
          Merb.logger.debug "Pulling commits for #{repository[:name]}: #{commits_address}"
          Mash.new(JSON.parse(http.request(request).body))[:commits]
        end.first || {:authored_date => nil} # default to no commit date if no commit has occured
        Merb.logger.debug "#{commit.inspect}"
        repository[:last_commit_at] = DateTime.parse(commit[:authored_date]) unless commit[:authored_date].nil?
        
        ### compile attributes
        attributes = {
          :name => repository[:name],
          :source => repository[:url],
          :description => repository[:description],
          :last_commit_at => repository[:last_commit_at],
          :user => user
        }
        
        ### determine if slice has been recorded yet
        unless slice = Slice.first(:source => repository[:url])
          ### create the new slice
          slice = Slice.new(attributes)
          slice.save
        else
          ### update details
          slice.update_attributes(attributes)
        end
      end
    end
    
  end
  
end
