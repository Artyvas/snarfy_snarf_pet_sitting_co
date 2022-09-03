require "rails_helper"

RSpec.describe Pricing, type: :model do
  describe "#cat_price_compute!" do
    it "should generate a price for cats" do
      pricing = Pricing.create(animal_type: "Cat", hours_rq: 1, booking_id: 1)
      pricing.dog_price_compute!
      expect(pricing.complete).to eq(25)
    end
  end
  describe "#dog_price_compute!" do
    it "should generate a price for cats" do
      pricing = Pricing.create(animal_type: "Dog", hours_rq: 1, booking_id: 1)
      pricing.dog_price_compute!
      expect(pricing.complete).to eq(30)
    end
  end
  describe "#animal_price_compute!" do
    it "should generate a price for all other animal types" do
      pricing = Pricing.create(animal_type: "", hours_rq: 1, booking_id: 1)
      pricing.dog_price_compute!
      expect(pricing.complete).to eq(20)
    end
  end
end
