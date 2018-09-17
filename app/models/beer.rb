# frozen_string_literal: true

class Beer < ApplicationRecord
  # Beer model

  include RatingAverage
  belongs_to :brewery
  has_many :ratings, dependent: :destroy

  def to_s
    "#{name}: #{brewery.name}"
  end
end
