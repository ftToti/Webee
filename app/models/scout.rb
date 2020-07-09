class Scout < ApplicationRecord
	belongs_to :user
	belongs_to :request

	validates :request_id, uniqueness: { scope: :user_id }

        def create_notification_scout!(current_user)
            temp = Notification.where(["visitor_id = ? and visited_id = ? and request_id = ? and action = ?", current_user.id, user_id, request_id, 'scout'])
            if temp.blank?
                notification = current_user.active_notifications.new(
                    visited_id: user_id,
                    request_id: request_id,
                    action: 'scout'
                )
                notification.save if notification.valid?
            end
        end
end
