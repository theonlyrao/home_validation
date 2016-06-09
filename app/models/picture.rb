class Picture < ActiveRecord::Base
  has_and_belongs_to_many :homes
  has_attached_file :picture
  #validates_attachment_file_name :picture
  validates_attachment_file_name :picture, :matches => [/png\Z/, /jpe?g\Z/]

  before_post_process :parse_for_location

  def parse_for_location
    
  end

end
