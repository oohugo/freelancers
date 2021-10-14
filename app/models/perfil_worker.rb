class PerfilWorker < ApplicationRecord
  belongs_to :worker
  has_many :feedback_worker, through: :worker
end
