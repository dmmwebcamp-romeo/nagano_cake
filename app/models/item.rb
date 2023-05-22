class Item < ApplicationRecord
  has_many :cart_items
  belongs_to :genre

  has_one_attached :image

  validates :name, presence:true
  validates :description, presence:true
  validates :price, presence:true

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [80, 100]).processed
  end

  def with_tax_price
      (price * 1.1).floor
  end

end
