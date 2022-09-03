require "rails_helper"

RSpec.describe "Bookings", type: :request do
  describe "GET /bookings" do
    it "returns an array of bookings" do
      user = User.create!(name: "test", email: "test@email.com", password: "password", admin: true)
      Booking.create!(first_name: "example first name 1", last_name: "example last name 1", animal_first: "example animal first 1", animal_last: "example animal last 1", animal_type: "example animal type 1", hours_rq: 1, date_of_service: 02 - 10 - 2022, price: 30)
      Booking.create!(first_name: "example first name 2", last_name: "example last name 2", animal_first: "example animal first 2", animal_last: "example animal last 2", animal_type: "example animal type 2", hours_rq: 1, date_of_service: 02 - 10 - 2022, price: 30)
      Booking.create!(first_name: "example first name 3", last_name: "example last name 3", animal_first: "example animal first 3", animal_last: "example animal last 3", animal_type: "example animal type 3", hours_rq: 1, date_of_service: 02 - 10 - 2022, price: 30)

      get "/api/bookings"
      bookings = JSON.parse(response.body)

      expect(response).to have_http_status(200)
      expect(bookings.length).to eq(3)
    end
  end

  describe "POST /bookings" do
    it "creates a booking" do
      user = User.create!(name: "test", email: "test@email.com", password: "password", admin: true)
      jwt = JWT.encode(
        { user_id: user.id },
        Rails.application.credentials.fetch(:secret_key_base),
        "HS256"
      )

      post "/api/bookings",
        params: { first_name: "example first name 1", last_name: "example last name 1", animal_first: "example animal first 1", animal_last: "example animal last 1", animal_type: "example animal type 1", hours_rq: 1, date_of_service: 02 - 10 - 2022, price: 30 },
        headers: { "Authorization" => "Bearer #{jwt}" }
      booking = JSON.parse(response.body)

      expect(response).to have_http_status(200)
      expect(booking["first_name"]).to eq("example first name 1")
      expect(booking["last_name"]).to eq("example last name 1")
      expect(booking["animal_first"]).to eq("example animal first 1")
      expect(booking["animal_last"]).to eq("example animal last 1")
      expect(booking["animal_type"]).to eq("example animal type 1")
      expect(booking["hours_rq"]).to eq(1)
      expect(booking["date_of_service"]).to eq(02 - 10 - 2022)
      expect(booking["price"]).to eq(30)
    end

    it "should be unprocessable with invalid params" do
      user = User.create!(name: "test", email: "test@email.com", password: "password", admin: true)
      jwt = JWT.encode(
        { user_id: user.id },
        Rails.application.credentials.fetch(:secret_key_base),
        "HS256"
      )

      post "/api/bookings",
        params: {},
        headers: { "Authorization" => "Bearer #{jwt}" }
      booking = JSON.parse(response.body)

      expect(response).to have_http_status(422)
    end

    it "should be unauthorized without a valid jwt" do
      post "/api/bookings", params: {}
      booking = JSON.parse(response.body)

      expect(response).to have_http_status(401)
    end
  end

  describe "GET /bookings/:id" do
    it "returns a hash with the appropriate attributes" do
      user = User.create!(name: "test", email: "test@email.com", password: "password", admin: true)
      booking = Booking.create!(first_name: "example first name 1", last_name: "example last name 1", animal_first: "example animal first 1", animal_last: "example animal last 1", animal_type: "example animal type 1", hours_rq: 1, date_of_service: 02 - 10 - 2022, price: 30)

      get "/api/bookings/#{booking.id}"
      booking = JSON.parse(response.body)

      expect(response).to have_http_status(200)
      expect(booking["first_name"]).to eq("example first name 1")
      expect(booking["last_name"]).to eq("example last name 1")
      expect(booking["animal_first"]).to eq("example animal first 1")
      expect(booking["animal_last"]).to eq("example animal last 1")
      expect(booking["animal_type"]).to eq("example animal type 1")
      expect(booking["hours_rq"]).to eq(1)
      expect(booking["date_of_service"]).to eq(02 - 10 - 2022)
      expect(booking["price"]).to eq(30)
    end
  end

  describe "PATCH /bookings/:id" do
    it "updates a booking" do
      user = User.create!(name: "test", email: "test@email.com", password: "password", admin: true)
      jwt = JWT.encode(
        { user_id: user.id },
        Rails.application.credentials.fetch(:secret_key_base),
        "HS256"
      )
      booking = Booking.create!(first_name: "example first name 1", last_name: "example last name 1", animal_first: "example animal first 1", animal_last: "example animal last 1", animal_type: "example animal type 1", hours_rq: 1, date_of_service: 02 - 10 - 2022, price: 30)

      patch "/api/bookings/#{booking.id}",
        params: { first_name: "Updated first name" },
        headers: { "Authorization" => "Bearer #{jwt}" }
      booking = JSON.parse(response.body)

      expect(response).to have_http_status(200)
      expect(booking["first_name"]).to eq("Updated first name")
    end

    it "should be unprocessable with invalid params" do
      user = User.create!(name: "test", email: "test@email.com", password: "password", admin: true)
      jwt = JWT.encode(
        { user_id: user.id },
        Rails.application.credentials.fetch(:secret_key_base),
        "HS256"
      )
      booking = Booking.create!(first_name: "example first name 1", last_name: "example last name 1", animal_first: "example animal first 1", animal_last: "example animal last 1", animal_type: "example animal type 1", hours_rq: 1, date_of_service: 02 - 10 - 2022, price: 30)

      patch "/api/bookings/#{booking.id}",
        params: { last_name: "" },
        headers: { "Authorization" => "Bearer #{jwt}" }
      booking = JSON.parse(response.body)

      expect(booking).to have_http_status(422)
    end

    it "should be unauthorized without a valid jwt" do
      patch "/api/booking/1", params: {}
      booking = JSON.parse(response.body)

      expect(response).to have_http_status(401)
    end
  end

  describe "DELETE /bookings/:id" do
    it "deletes a booking" do
      user = User.create!(name: "test", email: "test@email.com", password: "password", admin: true)
      jwt = JWT.encode(
        { user_id: user.id },
        Rails.application.credentials.fetch(:secret_key_base),
        "HS256"
      )
      Booking.create!(first_name: "example first name 1", last_name: "example last name 1", animal_first: "example animal first 1", animal_last: "example animal last 1", animal_type: "example animal type 1", hours_rq: 1, date_of_service: 02 - 10 - 2022, price: 30)
      Booking.create!(first_name: "example first name 2", last_name: "example last name 2", animal_first: "example animal first 2", animal_last: "example animal last 2", animal_type: "example animal type 2", hours_rq: 1, date_of_service: 02 - 10 - 2022, price: 30)
      Booking.create!(first_name: "example first name 3", last_name: "example last name 3", animal_first: "example animal first 3", animal_last: "example animal last 3", animal_type: "example animal type 3", hours_rq: 1, date_of_service: 02 - 10 - 2022, price: 30)

      delete "/api/bookings/#{Booking.first.id}",
        headers: { "Authorization" => "Bearer #{jwt}" }
      message = JSON.parse(response.body)

      expect(response).to have_http_status(200)
      expect(Booking.count).to eq(2)
    end

    it "should be unauthorized without a valid jwt" do
      delete "/api/bookings/1"
      booking = JSON.parse(response.body)

      expect(response).to have_http_status(401)
    end
  end
end
