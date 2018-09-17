# frozen_string_literal: true

class Rating < ApplicationRecord
  # Rating model

  belongs_to :beer

  def to_s
    "#{beer.name} #{score}"
  end
end
