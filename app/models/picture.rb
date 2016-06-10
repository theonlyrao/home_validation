class Picture < ActiveRecord::Base
  has_and_belongs_to_many :homes
  has_attached_file :picture, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  }
  #validates_attachment_file_name :picture
  validates_attachment_file_name :picture, :matches => [/png\Z/, /jpe?g\Z/]

  before_post_process :parse_for_location

  def parse_for_location
    
  end

end
