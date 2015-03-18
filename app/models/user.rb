class User < ActiveRecord::Base
	has_many :targets
	has_many :carts
	has_many :cart_products, through: :carts, source: :target
end
