require 'rails_helper'
include Helpers

RSpec.describe User, type: :model do
  it "has the username set correctly" do
    user = User.new username:"Pekka"

    expect(user.username).to eq("Pekka")
  end

  it "is not saved without a password" do
    user = User.create username:"Pekka"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  describe "the password is validated" do
    it "so it is not too short" do
      user = User.create username:"Pekka", password:"abc", password_confirmation: "abc"
      expect(user).not_to be_valid
    end

    it "so it has at least one upper case" do
      user = User.create username:"Pekka", password:"abcd3", password_confirmation: "abcd3"
      expect(user).not_to be_valid
    end


    it "and with terms met is valid" do
      user = User.create username:"Pekka", password:"abcD1", password_confirmation: "abcD1"
      expect(user).to be_valid
    end
  end

  

  describe "with a proper password" do
    let(:user) { FactoryBot.create(:user) }
  
    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end
  
    it "and with two ratings, has the correct average rating" do
      FactoryBot.create(:rating, score: 10, user: user)
      FactoryBot.create(:rating, score: 20, user: user)
  
      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end

  describe "favorite beer" do
    let(:user){ FactoryBot.create(:user) }
  
    it "has method for determining one" do
      expect(user).to respond_to(:favorite_beer)
    end
  
    it "without ratings does not have one" do
      expect(user.favorite_beer).to eq(nil)
    end

    it "is the only rated if only one rating" do
      beer = FactoryBot.create(:beer)
      rating = FactoryBot.create(:rating, score: 20, beer: beer, user: user)
    
      expect(user.favorite_beer).to eq(beer)
    end

    it "is the one with highest rating if several rated" do
      create_beers_with_many_ratings({user: user}, 10, 20, 15, 7, 9)
      best = create_beer_with_rating({ user: user }, 25 )
    
      expect(user.favorite_beer).to eq(best)
    end 
  end

  describe "favorite style" do
    let(:user){ FactoryBot.create(:user)}

    it "has a method for determining one" do
      expect(user).to respond_to(:favorite_style)
    end

    it "without ratings does not have one" do
      expect(user.favorite_style).to eq(nil)
    end

    it "is the only rated if only one rating" do
      beer = FactoryBot.create(:beer)
      rating = FactoryBot.create(:rating, score:20, beer: beer, user: user)

      expect(user.favorite_style).to eq(beer.style.name)
    end

    it "is the one with highest rating if several rated" do
      create_beers_with_many_ratings({user: user}, 10, 20)
      beer = create_beer_with_rating({ user: user, name: "TEST" }, 45 )

      expect(user.favorite_style).to eq(beer.style.name)
      
    end
  end
  describe "favorite brewery" do
    let(:user){ FactoryBot.create(:user)}

    it "has a method for determining one" do
      expect(user).to respond_to(:favorite_brewery)
    end

    it "without ratings does not have one" do
      expect(user.favorite_brewery).to eq(nil)
    end

    it "is the only rated if only one rating" do
      beer = FactoryBot.create(:beer)
      rating = FactoryBot.create(:rating, score:20, beer: beer, user: user)

      expect(user.favorite_brewery).to eq(beer.brewery.name)
    end

    it "is the one with highest rating if several rated" do
      create_beers_with_many_ratings({user: user}, 10, 20)
      brewery = Brewery.create name: "Test", year: 2015
      beer = create_beer_with_rating({ user: user, brewery: brewery }, 45 )

      expect(user.favorite_brewery).to eq(beer.brewery.name)
      
    end
  end
end

