class Project < ApplicationRecord
  validates :title, :description, :max_per_hour, :deadline, :place, presence: true
  validates :max_per_hour, numericality: { greater_than: 0 }
  validate :deadline_in_the_future
  validate :place_only_valid_options

  enum status: { avaliable: 0, suspend: 10, finished: 20 }
  has_many :proposals
  has_many :feedback_projects
  has_many :worker, through: :proposals
  belongs_to :employer

  def deadline_in_the_future
    errors.add(:deadline, 'não pode ser em datas passadas') if deadline && deadline < Date.today
  end

  def place_only_valid_options
    errors.add(:place, 'não pode ser uma opção não especificada') if place &&
                                                                     !place.eql?('remote') && !place.eql?('presential')
  end
end
