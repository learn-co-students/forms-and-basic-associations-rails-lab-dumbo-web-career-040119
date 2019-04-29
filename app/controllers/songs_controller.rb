class SongsController < ApplicationController

  before_action :get_song, only: [:edit, :update, :show, :destroy]

  def index
    @songs = Song.all
  end

  def new
    @song = Song.new
  end

  def create
    @song = Song.new(song_params)
    @song.genre_name = params[:song][:genre_id]
    if @song.save
      redirect_to @song
    else
      render :new
    end
  end

  def update
    @song.update(song_params)

    if @song.save
      redirect_to @song
    else
      render :edit
    end
  end

  def destroy
    @song.destroy
    flash[:notice] = "Song deleted."
    redirect_to songs_path
  end

  private

  def get_song
    @song = Song.find(params[:id])
  end

  def song_params
    params.require(:song).permit(:title, :artist_name, note_contents: [])
  end
end
