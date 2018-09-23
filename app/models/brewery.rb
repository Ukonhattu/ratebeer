# frozen_string_literal: true

class Brewery < ApplicationRecord
  # Brewery model

  include RatingAverage
  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  validates :name, presence: true
  validate :validate_year

  def validate_year
    if year < 1040 || year > Time.now.year
      errors.add(:year, "Not a valid year")
    end
  end

  def print_report
    puts name
    puts "established at year #{year}"
    puts "number of beers #{beers.count}"
  end

  def restart
    self.year = 2018
    puts "changed year to #{year}"
  end

  def to_s
    "#{name} : #{year}"
  end
end
