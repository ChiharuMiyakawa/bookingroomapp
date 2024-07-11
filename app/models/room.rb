class Room < ApplicationRecord
    belongs_to :user
    has_many :reservations, dependent: :destroy
    has_one_attached :image 
    validates :name, presence: true
    validates :content, presence: true
    validates :price, presence: true
    validates :address, presence: true
    validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
    
    before_save :convert_price_to_integer

    private
  
    def convert_price_to_integer
      self.price = price.to_i if price.is_a?(String)
    end

end
