class OrderGood < ApplicationRecord
  belongs_to :item
  belongs_to :order

  validates :item_id,         presence: true
  validates :order_id,        presence: true
  validates :amount,          presence: true, numericality: true
  validates :price_in,        presence: true, numericality: true
  validates :making_status,   presence: true
	enum making_status: {start_not_possible: 0, production_pending: 1, in_production: 2, production_complete: 3}

  def sum_of_price
    item.add_tax_price * amount
  end
end
