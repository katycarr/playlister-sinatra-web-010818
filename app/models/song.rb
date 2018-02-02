class Song < ActiveRecord::Base
  belongs_to :artist
  has_many :song_genres
  has_many :genres, through: :song_genres

  include Slugifiable

  def self.find_by_slug(slugified_title)
    Song.find do |song|
      song.slug == slugified_title
    end
  end

end
