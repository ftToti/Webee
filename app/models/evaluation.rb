class Evaluation < ApplicationRecord
	belongs_to :user
	belongs_to :request
	validates_uniqueness_of :request_id, scope: :user_id

	enum status: {done: true, yet: false}
end
