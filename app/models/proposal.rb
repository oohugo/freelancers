class Proposal < ApplicationRecord
  validates :description, :hourly_value, :hours_per_week, :date_close, presence: true
  validates :hourly_value, :hours_per_week, numericality: { greater_than: 0 }
  validate :date_close_future_and_less_than_deadline_of_project
  belongs_to :project
  belongs_to :worker
  enum status: { pending: 0, accepted: 10, rejected: 20, canceled: 30 }

  def date_close_future_and_less_than_deadline_of_project
    errors.add(:date_close, 'deve estar no futuro') if date_close && date_close < Date.today
    if project && date_close && project.deadline < date_close
      errors.add(:date_close, 'deve ser mais cedo que a data limite do projeto')
    end
  end
end
