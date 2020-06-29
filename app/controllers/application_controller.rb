class ApplicationController < ActionController::Base
	# ログイン後のリダイレクト先
	def after_sign_in_path_for(resource)
		case resource
		# 管理者の場合
		when Admin
			admins_top_path
		# ユーザの場合
		when User
			root_path
		end
	end
	# ログアウト後のリダイレクト先
	def after_sign_out_path_for(resource)
		new_user_session_path
	end
end
