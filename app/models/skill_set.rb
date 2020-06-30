class SkillSet < ApplicationRecord
	has_many :skill_sets, dependent: :destroy
	belongs_to :possible, class_name: 'User', optional: true
	belongs_to :good, class_name: 'User', optional: true
	belongs_to :necessary, class_name: 'Request', optional: true
end
