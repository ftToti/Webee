class Scout < ApplicationRecord
	belongs_to :user
	belongs_to :request
	has_many :notifications, dependent: :destroy
	validates_uniqueness_of :request_id, scope: :user_id
end
