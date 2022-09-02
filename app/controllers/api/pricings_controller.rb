class Api::PricingsController < ApplicationController
  def index
    @pricing = current_user.pricings
    render "index.json.jb"
  end

  def show
    @pricing = current_user.pricings.find_by(id: params[:id])
    render "show.json.jb"
  end

  def create
    # Open the bookings table
    # Find the booking with an id that matches the booking_id given by the user
    booking = Booking.find_by(id: params[:booking_id])
    if booking.animal_type == "Cat"
      animal_add_rate = 5
    elsif booking.animal_type == "Dog"
      animal_add_rate = 10
    else
      animal_add_rate = 1
    end

    calculated_total = 20 + animal_add_rate * booking.hours_rq

    @pricing = Pricing.new(
      user_id: current_user.id,
      booking_id: params[:product_id],
      total_price: calculated_total,
    )
    @pricing.save
    render "show.json.jb"
  end
end
