class Favorite < ApplicationRecord
	belongs_to :user
	belongs_to :request

	validates :request_id, uniqueness: { scope: :user_id }
end
