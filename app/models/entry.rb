class Entry < ApplicationRecord
	belongs_to :user
	belongs_to :request

	validates :request_id, uniqueness: { scope: :user_id }

        def create_notification_entry!(current_user)
            temp = Notification.where(["visitor_id = ? and visited_id = ? and request_id = ? and action = ?", current_user.id, self.request.user_id, request_id, 'entry'])
            if temp.blank?
                notification = current_user.active_notifications.new(
                    visited_id: self.request.user_id,
                    request_id: request_id,
                    action: 'entry'
                )
                notification.save if notification.valid?
            end
        end
end
