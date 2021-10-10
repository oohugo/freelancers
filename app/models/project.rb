class Project < ApplicationRecord
  validates :title, :description, :max_per_hour, :deadline, :place, presence: true
  enum status: { avaliable: 0, canceled: 20 }
  has_many :proposals
  belongs_to :employer
end
