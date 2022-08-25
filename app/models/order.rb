class Order < ApplicationRecord
  has_many :order_goods,   dependent: :destroy
  belongs_to :customer

  validates :customer_id,       presence: true
  validates :name,              presence: true
  validates :postal_code,       presence: true, numericality: true, length: { minimum: 7, maximum: 7 }
  validates :address,           presence: true
  validates :postage,           presence: true, numericality: true
  validates :total_payment,     presence: true, numericality: true
  validates :payment_method,    presence: true
  validates :order_status,      presence: true

  enum payment_method:  { credit_card: 0, transfer: 1 }
  enum order_status:    { payment_waiting: 0, payment_confirmation: 1, in_production: 2, preparing_delivery: 3, delivered: 4 }

  def address_display
    '〒' + postal_code + ' ' + address
  end

end
