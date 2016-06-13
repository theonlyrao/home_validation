class Picture < ActiveRecord::Base
  has_and_belongs_to_many :homes
  has_attached_file :picture, url: ":s3_domain_url", path: "/:class/:attachment/:id_partition/:style/:filename", styles: {
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
  
  def self.no_gps?(raw_picture)
    @raw_picture = raw_picture
    file = @raw_picture.tempfile
    @gps = EXIFR::JPEG.new(file).gps
    @gps.nil?
  end
end
