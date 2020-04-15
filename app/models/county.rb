class County < ApplicationRecord
  belongs_to :city
  has_many :towns
end
