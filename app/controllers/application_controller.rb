class ApplicationController < ActionController::Base
  
  # includeによりSessionsHelperで定義した
  # logged_in?メソッドを使えるようにしている
  include SessionsHelper
  
  private
  
  # ユーザがログインしていない状態だとログインページに遷移させるメソッド
  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
  
  def counts(user)
    @count_microposts = user.microposts.count
    @count_followings = user.followings.count
    @count_followers = user.followers.count
  end
end
