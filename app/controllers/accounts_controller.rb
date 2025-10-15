class AccountsController < ApplicationController
  before_action :require_login

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to account_path, notice: "アカウント情報を更新しました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    current_user.destroy
    reset_session
    redirect_to root_path, notice: "退会が完了しました。ご利用ありがとうございました。"
  end

  # パスワード変更フォーム表示
  def edit_password
    @user = current_user
  end

  # パスワード更新処理
  def update_password
    @user = current_user

    if @user.authenticate(params[:user][:current_password])
      if @user.update(password_params)
        redirect_to account_path, notice: "パスワードを変更しました。"
      else
        flash.now[:alert] = "パスワードの更新に失敗しました。"
        render :edit_password, status: :unprocessable_entity
      end
    else
      flash.now[:alert] = "現在のパスワードが正しくありません。"
      render :edit_password, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
