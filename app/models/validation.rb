class Validation < ActiveRecord::Base
  belongs_to :home
  has_many :pictures, through: :home

  def validated?
    self.validated
  end

  def check_gps
    pictures.all? do |picture|
      valid_lat?(picture) && valid_long?(picture)
    end
  end

  private
  
  def valid_lat?(picture)
    (picture.lat.to_f - self.home.lat.to_f).abs < 0.001
  end

  def valid_long?(picture)
    (picture.long.to_f - self.home.long.to_f).abs < 0.001
  end
end
