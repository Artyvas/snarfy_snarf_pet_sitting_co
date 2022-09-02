class Booking < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :animal_first, presence: true
  validates :animal_last, presence: true
  validates :animal_type, presence: true
  validates :hours_rq, numericality: { greater_than: 0 }
  validates :date_of_service, presence: true

  
end
