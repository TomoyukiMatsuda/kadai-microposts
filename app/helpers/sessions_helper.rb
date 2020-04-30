module SessionsHelper
  # 現在ユーザを取得するメソッド
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
    # 下の式を短く書いている
    # if @current_user
    #   return @current_user
    # else
    #   @current_user = User.find_by(id: session[:user_id])
    # end
    # @current_userに値があればそのまま、なければsessionからidを代入する
  end
  
  # 現在ログインしているかどうか確認するメソッド
  def logged_in?
    !!current_user
    # 下の式を短く書いている
    # if current_user
    #   return true
    # else
    #   return false
    # end
    # current_userから値が返って来ればtrue, 値がnilならfalse
  end
end
