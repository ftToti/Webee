class Request < ApplicationRecord
	belongs_to :user
	belongs_to :request_genre
	has_many :notifications, dependent: :destroy
	has_many :favorites, dependent: :destroy
	has_many :scouts, dependent: :destroy
	has_many :scout_users, through: :scouts, source: :user
	has_many :entries, dependent: :destroy
	has_many :entry_users, through: :entries, source: :user
	has_many :participants, dependent: :destroy
	has_many :participant_users, through: :participants, source: :user
	has_many :necessary, class_name: 'SkillSet', foreign_key: 'necessary_id', dependent: :destroy
	has_many :skills, through: :necessary
	has_many :evaluations, dependent: :destroy
	has_many :evaluation_users, through: :evaluations, source: :user
	enum status: {wanted: 0, progress: 1, completed: 2, cancel: 3}
	# wanted => 募集中(依頼内容の編集可能、応募可能、スカウト可能、progressへ移行可能、cancelへ移行可能)
	# progress => 進行中(応募者削除、スカウト者削除、completedへ移行可能)
	# completed => 達成済み(応募者削除、参加者の実績を作成、参加者削除)
	# cancel => 取り下げ(応募者削除、スカウト者削除、参加者削除、wantedへ移行可能)

	validates :title, presence: true
	validates :content, presence: true
	validates :reward, presence: true
	validates :recruiment_end, presence: true
	validates :delivery_date, presence: true
	validates :recruiment_max, presence: true

end
