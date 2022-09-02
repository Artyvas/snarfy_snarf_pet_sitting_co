Rails.application.routes.draw do
  # EXAMPLE HTML ROUTE
  # get "/photos" => "photos#index"

  # EXAMPLE JSON ROUTE WITH API NAMESPACE
  # namespace :api do
  #   get "/photos" => "photos#index"
  # end
  namespace :api do
    get "/bookings" => "bookings#index"
    post "/bookings" => "bookings#create"
    get "/bookings/:id" => "bookings#show"
    patch "/bookings/:id" => "bookings#update"
    delete "/bookings/:id" => "bookings#destroy"
  end
end
