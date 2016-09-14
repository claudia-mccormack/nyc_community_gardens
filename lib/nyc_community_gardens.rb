require "nyc_community_gardens/version"
require 'unirest'

module NycCommunityGardens
  class CommunityGarden
    attr_reader :name, :address, :boro, :neighborhood

    def initialize(garden)
      @name = garden['name'],
      @address = garden['address'],
      @boro = garden['boro'],
      @neighborhood = garden['neighborhoodname']
    end

    def self.all
      gardens_array = Unirest.get("https://data.cityofnewyork.us/resource/yes4-7zbb.json").body
      gardens = []
      gardens_array.each do |garden|
        gardens << garden
      end
      gardens
    end

    def self.where
      key = search_term.keys.to_s
      value = search_term.values
      gardens_array = Unirest.get("https://data.cityofnewyork.us/resource/yes4-7zbb.json?#{key}=#{value}").body
      gardens = []
      gardens_array.each do |garden|
        gardens << garden
      end
    end

    def self.find_by(search_term)
      key = search_term.keys.first.to_s
      value = search_term.values.first
      garden = Unirest.get("https://data.cityofnewyork.us/resource/yes4-7zbb.json?#{key}=#{value}").body.first
      CommunityGarden.new(garden)
    end

  end
end
