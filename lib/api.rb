require_relative '../config/environment'
class API

    def initialize
        @base_url = "https://api.nasa.gov/neo/rest/v1/neo/browse" #constant, won't change
    end
     
    def get_asteroid_data
        asteroid_response_hash = HTTParty.get(@base_url + "?start_date=2020-01-01&end_date=2021-01-01&api_key=#{ENV['API_KEY']}") #gem does JSON parsing
        asteroid_hash_array = asteroid_response_hash["near_earth_objects"] #returns array of hashes that include asteroids
        self.create_asteroid_objects(asteroid_hash_array) #pass array in to create asteroid objects by using next defined method.
    end

    #pry
    #asteroid_response_hash.keys - Get the keys
    #asteroid_hash_array - Get API
    #asteroid_response_hash["near_earth_objects"] - Get actual objects and their attributes
    #asteroid_response_hash["near_earth_objects"].count - Find out number of asteroids
    #asteroid_response_hash["near_earth_objects"][0] - Get first asteroid and it's attributes
    #asteroid_response_hash["near_earth_objects"][0].keys - Get keys of first asteroid

    def create_asteroid_objects(asteroid_hash_array) #takes in an array of near earth objects 
        asteroid_hash_array.each {|asteroid_hash| Asteroid.new(asteroid_hash)} #gather asteroid information from hash 
    end
end

#data is grabbed here