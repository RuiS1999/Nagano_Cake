class Address < ApplicationRecord
  belongs_to :customer

  validates :customer_id,       presence: true
  validates :name,              presence: true
  validates :postal_code,       presence: true, numericality: true, length: { minimum: 7, maximum: 7 }
  validates :address,           presence: true

  def address_display
    '〒' + postal_code + ' ' + address + ' ' + name
  end
end
