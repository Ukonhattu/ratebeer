require 'rails_helper'
include Helpers

describe "Rating" do
  let!(:brewery) { FactoryBot.create :brewery, name:"Koff" }
  let!(:beer1) { FactoryBot.create :beer, name:"iso 3", brewery:brewery }
  let!(:beer2) { FactoryBot.create :beer, name:"Karhu", brewery:brewery }
  let!(:user) { FactoryBot.create :user }

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end

  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select('iso 3', from:'rating[beer_id]')
    fill_in('rating[score]', with:'15')

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(0).to(1)

    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq(15.0)
  end

  it "Ratings and count is rendered at index" do
    sign_in(username:"Pekka", password:"Foobar1")
    user = User.first
    create_beers_with_many_ratings({user: user}, 10, 20, 15, 7, 9)
    visit ratings_path
    expect(page).to have_content "Ratings count: 5"

    expect(page).to have_content "10"
    expect(page).to have_content "20"
    expect(page).to have_content "15"
    expect(page).to have_content "7"
    expect(page).to have_content "9"
  end

  it "Users own ratings rendered at users page" do
    sign_in(username:"Pekka", password:"Foobar1")
    user = User.first
    create_beers_with_many_ratings({user: user}, 10, 20, 15, 7, 9)
    visit user_path(user)
    expect(page).to have_content "has 5 ratings"

    expect(page).to have_content "10"
    expect(page).to have_content "20"   
    expect(page).to have_content "15"
    expect(page).to have_content "7"
    expect(page).to have_content "9"
  end

  it "User can delete rating" do
    sign_in(username:"Pekka", password:"Foobar1")
    user = User.first
    create_beers_with_many_ratings({user: user}, 10)
    visit user_path(user)
    expect{
        click_link('delete')
      }.to change{user.ratings.count}.by(-1)
  end
end