class Item < ApplicationRecord
<<<<<<< HEAD
  
  belongs_to :genre
  
  has_one_attached :image
  
  
=======

  belongs_to :genre

  has_one_attached :image

  validates :name, presence:true
  validates :description, presence:true
  validates :price, presence:true

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [200, 200]).processed
  end
  
  def add_tax_sales_price
    (self.price * 1.10).round
  end

>>>>>>> origin/develop
end
