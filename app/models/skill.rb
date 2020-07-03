class Skill < ApplicationRecord
	has_many :skill_sets, dependent: :destroy
	has_many :users, :through => :skill_sets
end
