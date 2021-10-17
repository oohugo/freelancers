class Employer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :projects
  has_many :feedback_employer

  def calculate_rating
    ratings = feedback_employer.map(&:rating)
    self.rating = (ratings.sum / ratings.size) unless ratings.empty?
  end
end
