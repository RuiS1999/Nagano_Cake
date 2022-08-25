class Customer < ApplicationRecord
  has_many :cart_items,   dependent: :destroy
  has_many :order,        dependent: :destroy
  has_many :addresses,    dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email,             uniqueness: true
  validates :last_name,         presence: true
  validates :first_name,        presence: true
  validates :last_name_kana,    presence: true, format: {with: /\A[\p{katakana} ー－&&[^ -~｡-ﾟ]]+\z/}
  validates :first_name_kana,   presence: true, format: {with: /\A[\p{katakana} ー－&&[^ -~｡-ﾟ]]+\z/}
  validates :postal_code,       presence: true, numericality: true, length: { minimum: 7, maximum: 7 }
  validates :address,           presence: true
  validates :telephone_number,  presence: true, numericality: true
  validates :is_active,         inclusion: {in: [true, false]}

  def address_display
    '〒' + postal_code + ' ' + address + ' ' + last_name + first_name
  end

  def full_name
    last_name + first_name
  end

  def full_name_kana
    last_name_kana + first_name_kana
  end

end
