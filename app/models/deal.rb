class Deal < ApplicationRecord
  belongs_to :product
  belongs_to :buyer, :class_name => 'User', :foreign_key => 'buyer_id'
  belongs_to :seller, :class_name => 'User', :foreign_key => 'seller_id'
end
