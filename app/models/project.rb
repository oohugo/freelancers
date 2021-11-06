class Project < ApplicationRecord
  validates :title, :description, :max_per_hour, :deadline, :place, presence: true
  validates :max_per_hour, numericality: { greater_than: 0 }
  validate :deadline_in_the_future
  validate :place_only_valid_options

  enum status: { avaliable: 0, suspend: 10, finished: 20 }

  belongs_to :employer
  has_many :proposals, dependent: :destroy
  has_many :feedback_projects, dependent: :destroy
  has_many :workers, through: :proposals

  def deadline_in_the_future
    errors.add(:deadline, 'não pode ser em datas passadas') if deadline && deadline < Time.zone.today
  end

  def place_only_valid_options
    errors.add(:place, 'não pode ser uma opção não especificada') if place &&
                                                                     !place.eql?('remote') && !place.eql?('presential')
  end
end
