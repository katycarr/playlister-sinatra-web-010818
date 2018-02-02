
class SongsController < ApplicationController
  enable :sessions
  use Rack::Flash

  get '/songs' do
    @songs = Song.all
    erb :'songs/index'
  end

  get '/songs/new' do
    @genres = Genre.all
    @artists = Artist.all

    erb :'songs/new'
  end

 #  {"song"=>{"name"=>"That One with the Guitar", "genre"=>"2"},
 # "artist"=>{"name"=>"Person with a Face"},
 # "submit"=>"Create Song"}

  post '/songs' do
    @song = Song.create(params[:song])
    @artist = Artist.find_by(name:params[:artist][:name])
    if !@artist
      @artist = Artist.create(name:params[:artist][:name])
    end
    @song.artist = @artist
    @song.save
    flash[:message] = "Successfully created song."
    redirect :"songs/#{@song.slug}"
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    erb :'songs/show'
  end

  get '/songs/:slug/edit' do
    @song = Song.find_by_slug(params[:slug])
    @genres = Genre.all
    @artists = Artist.all

    erb :"/songs/edit"
  end

  patch '/songs/:slug' do
    @song.update(params[:song])
    @song.save

    redirect "/songs/#{@song.slug}"
  end


end
