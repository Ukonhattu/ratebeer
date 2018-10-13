# frozen_string_literal: true

class Beer < ApplicationRecord
  # Beer model

  include RatingAverage
  belongs_to :brewery
  belongs_to :style
  has_many :ratings, dependent: :destroy
  has_many :raters, -> { distinct }, through: :ratings, source: :users


  validates :name, presence: true

  def to_s
    "#{name}: #{brewery.name}"
  end

  def self.top(n)
    sorted_by_rating_in_desc_order = Beer.all.sort_by{ |b| -(b.average_rating || 0) }
    top = sorted_by_rating_in_desc_order[0,3]
    # palauta listalta parhaat n kappaletta
    # miten? ks. http://www.ruby-doc.org/core-2.5.1/Array.html
  end
end
