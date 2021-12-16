class Feedback < ApplicationRecord
  belongs_to :feedbackable, polymorphic: true
  belongs_to :project
  after_save :calcule_rating_feedbackable
  validates :rating, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
  validates :rating, :comment, :feedbackable, presence: true

  private

  def calcule_rating_feedbackable
    ratings = feedbackable.feedbacks.map(&:rating)
    feedbackable.rating = (ratings.sum / ratings.size) unless ratings.empty?
    errors.add(feedbackable, message: 'erro em atualizar feedback') unless feedbackable.save
  end
end
