class Painting < ApplicationRecord
    belongs_to :museum
    belongs_to :artist 
    validates :name, presence: true 

    def museum_name=(name)
        self.museum = Museum.find_or_create_by(name: name)
    end

    def museum_name
        self.museum ? self.museum.name: nil
    end

    def artist_name=(name)
        self.artist = Artist.find_or_create_by(name: name)
    end

    def artist_name
        self.artist ? self.artist.name: nil
    end
end