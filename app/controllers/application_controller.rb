class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user.present?
  end

  # 未ログイン時の制限（共通処理）
  def require_login
    unless logged_in?
      redirect_to login_path, alert: "ログインが必要です。"
    end
  end
end
