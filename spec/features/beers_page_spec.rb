require 'rails_helper'
include Helpers

describe "Beer" do
    before :each do
        User.create username: "Pekka", password:"Foobar1", password_confirmation:"Foobar1"
        sign_in(username:"Pekka", password:"Foobar1")
        Brewery.create name: "TestBr", year: 2015
    end

    it "Can be made with a proper name" do

        visit new_beer_path
        fill_in('beer_name', with:'Testiolut')
        expect{
            click_button "Create Beer"
          }.to change{Beer.count}.from(0).to(1)
    end

    it "when empty name, is not saved" do
        visit new_beer_path

        click_button "Create Beer"
        expect(Beer.count).to eq(0)
    end
end