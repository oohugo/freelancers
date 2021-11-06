class Employer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :projects, dependent: :destroy
  has_many :feedback_employers, dependent: :destroy

  def calculate_rating
    ratings = feedback_employers.map(&:rating)
    self.rating = (ratings.sum / ratings.size) unless ratings.empty?
  end
end
