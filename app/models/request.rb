class Request < ApplicationRecord
	belongs_to :user
	belongs_to :request_genre
	has_many :favorites, dependent: :destroy
	has_many :favorited_users, through: :favorites, source: :user
	has_many :scouts, dependent: :destroy
	has_many :entries, dependent: :destroy
	has_many :necessary, class_name: 'SkillSet', foreign_key: 'necessary_id', dependent: :destroy
	has_many :skills, through: :necessary
	has_many :evaluations, dependent: :destroy
	has_many :participants, dependent: :destroy

	enum status: {wanted: 0, progress: 1, completed: 2, cancel: 3}
	# wanted => 募集中(依頼内容の編集可能、応募可能、スカウト可能、progressへ移行可能、cancelへ移行可能)
	# progress => 進行中(応募者削除、スカウト者削除、completedへ移行可能)
	# completed => 達成済み(応募者削除、参加者の実績を作成、参加者削除)
	# cancel => 取り下げ(応募者削除、スカウト者削除、参加者削除、wantedへ移行可能)
end
