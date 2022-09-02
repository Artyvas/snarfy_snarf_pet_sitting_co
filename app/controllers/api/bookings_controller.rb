class Api::BookingsController < ApplicationController
  def index
    @bookings = Booking.all
    render "index.json.jb"
  end

  def create
  end

  def show
  end

  def update
  end

  def destroy
  end
end
