class Room < ApplicationRecord
	has_many :messages, dependent: :destroy
	has_many :joins, dependent: :destroy
	has_many :users, through: :joins
end
