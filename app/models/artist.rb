class Artist < ActiveRecord::Base
  has_many :songs
  has_many :genres, through: :songs

  include Slugifiable

  def self.find_by_slug(slugified_title)
    Artist.find do |artist|
      artist.slug == slugified_title
    end
  end
end
