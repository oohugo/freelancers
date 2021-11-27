class Feedback < ApplicationRecord
  belongs_to :feedbackable, polymorphic: true
  belongs_to :project
  after_save :calcule_rating_feedbackable

  private

  def calcule_rating_feedbackable
    ratings = feedbackable.feedbacks.map(&:rating)
    feedbackable.rating = (ratings.sum / ratings.size) unless ratings.empty?
    errors.add(feedbackable, message: 'erro em atualizar feedback') unless feedbackable.save
  end
end
