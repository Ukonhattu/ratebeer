# frozen_string_literal: true

module RatingAverage
  # Model for calculating Ratings average

  extend ActiveSupport::Concern
  def average_rating
    ratings.average(:score)
  end
end
