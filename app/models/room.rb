class Room < ApplicationRecord
	has_many :talks, dependent: :destroy
	has_many :joins, dependent: :destroy
end
