class Picture < ActiveRecord::Base
  has_and_belongs_to_many :homes
  has_attached_file :picture, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  }
  
  validates_attachment_file_name :picture, :matches => [/png\Z/, /jpe?g\Z/, /PNG\Z/, /JPE?G\Z/]

  def self.raw_picture
    @raw_picture
  end

  def self.gps
    @gps
  end
  
  def self.no_gps?(picture_params)
    return true unless picture_params
    @raw_picture = picture_params["0"][:picture]
    file = @raw_picture.tempfile
    @gps = EXIFR::JPEG.new(file).gps
    @gps.nil?
  end
end
