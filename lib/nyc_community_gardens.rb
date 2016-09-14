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
      create_gardens(gardens_array)
    end

    def self.where(search_term)
      key = search_term.keys.first.to_s
      value = search_term.values.first
      gardens_array = Unirest.get("https://data.cityofnewyork.us/resource/yes4-7zbb.json?#{key}=#{value}").body
      create_gardens(gardens_array)
    end

    def self.find_by(search_term)
      key = search_term.keys.first.to_s
      value = search_term.values.first
      garden = Unirest.get("https://data.cityofnewyork.us/resource/yes4-7zbb.json?#{key}=#{value}").body.first
      CommunityGarden.new(garden)
    end

    def self.create_gardens(gardens_array)
      gardens = []
      gardens_array.each do |garden|
        gardens << garden
      end
    end

  end
end
