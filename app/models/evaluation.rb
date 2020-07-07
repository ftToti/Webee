class Evaluation < ApplicationRecord
	belongs_to :user
	belongs_to :request
	enum status: {done: true, yet: false}

	validates :request_id, uniqueness: { scope: :user_id }
	validates :rate, numericality: {
		less_than_or_equal_to: 5,
		greater_than_or_equal_to: 0.5
	}, presence: true
end
