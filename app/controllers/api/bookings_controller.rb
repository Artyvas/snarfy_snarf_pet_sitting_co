class Api::BookingsController < ApplicationController
  before_action :authenticate_admin, except: [:index, :show]

  def index
    @bookings = Booking.all
    if params[:search]
      @bookings = @bookings.where("last_name ILIKE ?", "%#{params[:search]}%")
    end
    render "index.json.jb"
  end

  def create
    @booking = Booking.new(
      first_name: params[:first_name],
      last_name: params[:last_name],
      animal_first: params[:animal_first],
      animal_last: params[:animal_last],
      animal_type: params[:animal_type],
      hours_rq: params[:hours_rq],
      date_of_service: params[:date_of_service],
    )
    if @booking.save
      render "show.json.jb"
    else
      render json: { errors: @booking.errors.full_messages }, status: 422
    end
  end

  def show
    @booking = Booking.find_by(id: params[:id])
    render "show.json.jb"
  end

  def update
    @booking = Booking.find_by(id: params[:id])
    @booking.first_name = params[:first_name] || @booking.first_name
    @booking.last_name = params[:last_name] || @booking.last_name
    @booking.animal_first = params[:animal_first] || @booking.animal_first
    @booking.animal_last = params[:animal_last] || @booking.animal_last
    @booking.animal_type = params[:animal_type] || @booking.animal_type
    @booking.hours_rq = params[:hours_rq] || @booking.hours_rq
    @booking.date_of_service = params[:date_of_service] || @booking.date_of_service
    if @booking.save
      render "show.json.jb"
    else
      render json: { errors: @booking.errors.full_messages }, status: 422
    end
  end

  def destroy
    booking = Booking.find_by(id: params[:id])
    booking.destroy
    render json: { message: "Booking successfully deleted" }
  end
end
