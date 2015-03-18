class Target < ActiveRecord::Base
	belongs_to :user
	has_many :target2s
	has_many :carts
end
