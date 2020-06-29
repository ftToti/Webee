class SkillSet < ApplicationRecord
	has_many :skill_sets, dependent: :destroy
	belongs_to :possible, class_name: 'User'
	belongs_to :good, class_name: 'User'
	belongs_to :necessary, class_name: 'Request'
end
