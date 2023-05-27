class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_items, dependent: :destroy

  enum status: { payment_waiting: 0, confirm_payment: 1, making: 2, preparing_ship: 3, finish_prepare: 4 }

  enum pay_option: { credit_card: 0, transfer: 1 }

  validates :pay_option,presence:true
  validates :post_code, presence: true, length: { is: 7 }
  validates :address, presence: true
  validates :name, presence: true

end