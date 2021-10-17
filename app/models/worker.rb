class Worker < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :feedback_worker
  has_one :perfil_worker
  has_many :proposal
  has_many :projects, through: :proposal

  def calculate_rating
    ratings = feedback_worker.map(&:rating)
    self.rating = (ratings.sum / ratings.size) unless ratings.empty?
  end
end
