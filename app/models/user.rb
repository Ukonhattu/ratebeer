class User < ApplicationRecord
    include RatingAverage

    has_secure_password

    validates :username, uniqueness: true,
                        length: {minimum: 3, maximum: 30}
    validates :password, length: {minimum: 4},
                        format: {with: /\d+/}, format: {with: /[A-Z]+/}
    has_many :ratings, dependent: :destroy
    has_many :beers, through: :ratings
    has_many :memberships

    def favorite_beer
        return nil if ratings.empty?
        ratings.order(score: :desc).limit(1).first.beer
    end

    def favorite_style
        return nil if ratings.empty?
        style_ratings_all = ratings.group_by{|r| r.beer.style}
        style_ratings = {}
        style_ratings_all.each{|r, v| style_ratings[r.name] = (v.sum(&:score) / v.size.to_f)}
        return style_ratings.max{|r,v| v}[0]
    end

    def favorite_brewery
        return nil if ratings.empty?

        br_ratings_all = ratings.group_by{|r| r.beer.brewery}
        br_ratings = {}
        br_ratings_all.each{|r, v| br_ratings[r.name] = (v.sum(&:score) / v.size.to_f)}
        return br_ratings.max{|r,v| v}[0]
    end

    def isInClub(club)
        memberships.each do |membership|
            return true if membership.beer_club == club
        end
        return false
    end
end