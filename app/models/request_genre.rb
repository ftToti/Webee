class RequestGenre < ApplicationRecord
	has_many :requests, dependent: :destroy
end
