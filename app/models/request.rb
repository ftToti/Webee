class Request < ApplicationRecord
	belongs_to :user
	belongs_to :request_genre
	has_many :favorites, dependent: :destroy
	has_many :scouts, dependent: :destroy
	has_many :entries, dependent: :destroy
	has_many :necessary, class_name: 'SkillSet', foreign_key: 'necessary_id', dependent: :destroy
	has_many :evaluations, dependent: :destroy
	has_many :participants, dependent: :destroy
end
