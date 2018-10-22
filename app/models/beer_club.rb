class BeerClub < ApplicationRecord
  has_many :memberships

  def to_s
    name.to_s
    end
end
