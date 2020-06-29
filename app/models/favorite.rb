class Favorite < ApplicationRecord
	belongs_to :user
	belongs_to :request
	has_many :notifications, dependent: :destroy
end
