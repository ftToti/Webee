class SkillSet < ApplicationRecord
	belongs_to :possible, class_name: 'User', optional: true
	belongs_to :good, class_name: 'User', optional: true
	belongs_to :necessary, class_name: 'Request', optional: true
	belongs_to :skill
end
