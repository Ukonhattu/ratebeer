require 'rails_helper'

RSpec.describe Beer, type: :model do
  it "has a name set correctly" do
    beer = Beer.create name: "Olut"
    expect(beer.name).to eq("Olut")
  end

  it "has a style set correctly" do
    beer = Beer.create name: "olut", style: "IPA"
    expect(beer.style).to eq("IPA")
  end

  it "is saved if it has name, style and brewery" do
    brewery = Brewery.create name: "Test", year: 2016
    beer = Beer.create name: "Olut", style: "IPA", brewery: brewery
    expect(beer).to be_valid
    expect(Beer.count).to eq(1)
  end

  it "is not saved if it has no style" do
    beer = Beer.create name: "Olut"
    expect(Beer.count).to eq(0)
  end

  it "is not saved if has no name" do
    beer = Beer.create style: "IPA"
    expect(Beer.count).to eq(0)
  end
end


