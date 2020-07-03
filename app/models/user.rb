class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         has_many :rooms, dependent: :destroy
         has_many :visitor, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
         has_many :visited, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy
         has_many :talks, dependent: :destroy
         has_many :joins, dependent: :destroy
         has_many :favorites, dependent: :destroy
         has_many :favorite_requests, through: :favorites, source: :request
         has_many :scouts, dependent: :destroy
         has_many :entries, dependent: :destroy
         has_many :requests, dependent: :destroy
         has_many :possible, class_name: 'SkillSet', foreign_key: 'possible_id', dependent: :destroy
         has_many :good, class_name: 'SkillSet', foreign_key: 'good_id', dependent: :destroy
         has_many :skills, through: :possible
         has_many :skills, through: :good
         has_many :evaluations, dependent: :destroy
         has_many :participants, dependent: :destroy
         has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
         has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
         has_many :following_users, through: :follower, source: :followed
         has_many :followed_users, through: :followed, source: :follower
         attachment :profile_image


        def favorited_by?(request)
            favorites.where(request_id: request).exists?
        end

        def following?(user)
            follower.where(followed_id: user).exists?
        end
end
