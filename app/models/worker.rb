class Worker < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :perfil_worker, dependent: :destroy
  has_many :proposals, dependent: :nullify
  has_many :projects, through: :proposals
  has_many :feedbacks, as: :feedbackable, dependent: :destroy
end
