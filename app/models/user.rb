class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         has_many :rooms, through: :joins, dependent: :destroy
         has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
         has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy
         has_many :messages, dependent: :destroy
         has_many :joins, dependent: :destroy
         has_many :rooms, through: :joins
         has_many :favorites, dependent: :destroy
         has_many :favorite_requests, through: :favorites, source: :request
         has_many :scouts, dependent: :destroy
         has_many :scout_requests, through: :scouts, source: :request
         has_many :entries, dependent: :destroy
         has_many :entry_requests, through: :entries, source: :request
         has_many :participants, dependent: :destroy
         has_many :participant_requests, through: :participants, source: :request
         has_many :requests, dependent: :destroy
         has_many :possible, class_name: 'SkillSet', foreign_key: 'possible_id', dependent: :destroy
         has_many :good, class_name: 'SkillSet', foreign_key: 'good_id', dependent: :destroy
         has_many :possible_skills, through: :possible, source: :skill
         has_many :good_skills, through: :good, source: :skill
         has_many :evaluations, dependent: :destroy
         has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
         has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
         has_many :following_users, through: :follower, source: :followed
         has_many :followed_users, through: :followed, source: :follower
         attachment :profile_image

         validates :name, presence: true, length: {maximum: 20, minimum: 2}
         validates :strong_point, length: {maximum: 30}

        def favorited_by?(request)
            favorites.where(request_id: request).exists?
        end

        def following?(user)
            follower.where(followed_id: user).exists?
        end

        def create_notification_follow!(current_user)
            temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ?", current_user.id, id, 'follow'])
            if temp.blank?
                notification = current_user.active_notifications.new(
                    visited_id: id,
                    action: 'follow'
                )
                notification.save if notification.valid?
            end
        end
end
