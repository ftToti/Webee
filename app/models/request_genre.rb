class RequestGenre < ApplicationRecord
	has_many :requests, dependent: :destroy

	validates :category, presence: true
end
