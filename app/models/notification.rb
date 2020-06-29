class Notification < ApplicationRecord
	belongs_to :visitor, class_name: 'User'
	belongs_to :visited, class_name: 'User'
	belongs_to :talk
	belongs_to :favorite
	belongs_to :scout
	belongs_to :entry
end
