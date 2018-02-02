class Genre < ActiveRecord::Base
  has_many :song_genres
  has_many :songs, through: :song_genres
  has_many :artists, through: :songs

  include Slugifiable

  def self.find_by_slug(slugified_title)
    Genre.find do |genre|
      genre.slug == slugified_title
    end
  end
end
