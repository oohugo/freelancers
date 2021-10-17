class PerfilWorker < ApplicationRecord
  validates :full_name, :birthdate, :qualification, :background, :expertise, presence: true
  belongs_to :worker
  has_many :feedback_worker, through: :worker
  validate :birthdate_old_than_eighteen
  has_one_attached :photo
  def birthdate_old_than_eighteen
    if birthdate && birthdate > 18.years.ago.to_date
      errors.add(:birthdate, 'tem que ter mais de 18 anos para criar um perfil')
    end
  end
end
