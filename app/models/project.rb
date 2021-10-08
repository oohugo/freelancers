class Project < ApplicationRecord
  validates :title, :description, :max_per_hour, :deadline, :place, presence: true
end
