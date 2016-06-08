class Validation < ActiveRecord::Base
  belongs_to :home
  has_many :pictures, through: :home
end
