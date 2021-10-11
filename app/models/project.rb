class Project < ApplicationRecord
  validates :title, :description, :max_per_hour, :deadline, :place, presence: true
  enum status: { avaliable: 0, suspend: 10, finished: 20 }
  has_many :proposals
  belongs_to :employer
end
