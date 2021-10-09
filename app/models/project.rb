class Project < ApplicationRecord
  validates :title, :description, :max_per_hour, :deadline, :place, presence: true
  enum status: { avaliable: 0, canceled: 20 }
end
