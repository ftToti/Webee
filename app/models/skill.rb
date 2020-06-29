class Skill < ApplicationRecord
	has_many :skill_sets, dependent: :destroy
end
