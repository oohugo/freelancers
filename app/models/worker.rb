class Worker < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :perfil_worker, dependent: :destroy
  has_many :feedback_workers, dependent: :destroy
  has_many :proposals, dependent: :nullify
  has_many :projects, through: :proposals

  def calculate_rating
    ratings = feedback_workers.map(&:rating)
    self.rating = (ratings.sum / ratings.size) unless ratings.empty?
  end
end
