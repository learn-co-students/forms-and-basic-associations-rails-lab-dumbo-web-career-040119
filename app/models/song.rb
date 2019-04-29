class Song < ActiveRecord::Base
  belongs_to :artist
  belongs_to :genre
  has_many :notes

  def genre_name
    self.genre ? self.genre.name : nil
  end

  def genre_name=(name)
    self.genre = Genre.find_by(name: name)
  end

  def artist_name
    self.artist ? self.artist.name : nil
  end

  def artist_name=(name)
    @artist = Artist.find_by(name: name)
    if @artist
      self.artist = @artist
    else
      self.artist = Artist.create(name: name)
    end
  end

  def note_contents
    @notes = self.notes
    @notes.map {|n| n.content}
  end

  def note_contents=(contents)
    contents.delete_if {|s| s == ""}
    @notes = contents.map{|c| Note.find_or_create_by(content: c)}
    # https://apidock.com/rails/v4.0.2/ActiveRecord/Relation/find_or_create_by
    @notes.each {|n| self.notes << n}
  end

end
