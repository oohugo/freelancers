class FeedbackEmployer < ApplicationRecord
  belongs_to :employer
  validates :rating, numericality: true
  before_save :normalize_rating

  private

  def normalize_rating
    self.rating = 5 if rating > 5
    self.rating = 0 if rating.negative?
  end
end
