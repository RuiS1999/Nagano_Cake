class Item < ApplicationRecord
  has_many :cart_items,   dependent: :destroy
  has_many :order_goods,  dependent: :destroy
  belongs_to :genre

  has_one_attached :image

  validates :genre_id,      presence: true
  validates :name,          presence: true
  validates :introduction,  presence: true
  validates :price_out,     presence: true,   numericality: {only_integer: true}
  validates :is_active,     inclusion: {in: [true, false]}

  def add_tax_price
    (self.price_out * 1.1).round
  end

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/sample.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end

end
