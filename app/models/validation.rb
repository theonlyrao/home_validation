class Validation < ActiveRecord::Base
  belongs_to :home
  has_many :pictures, through: :home

  def validated?
    self.validated
  end

  def check_gps
    home = self.home
    pictures = self.pictures
    diffs = pictures.map do |picture|
      [(picture.lat.to_f - home.lat.to_f).abs, (picture.long.to_f - home.long.to_f).abs] 
    end.flatten
    if diffs.any? { |diff| diff > 0.0005 }
      false
    else
      true
    end
  end
end
