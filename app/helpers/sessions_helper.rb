module SessionsHelper

  def sign_in(user)
    session = Session.find_by_user_id(user.id)
    if session.nil?
      Session.create(user_id: user.id, ip_address: request.remote_ip, last_session_date: Time.now)
    else
      session.update_attributes(ip_address: request.remote_ip, last_session_date: Time.now)
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_user
    if !logged_in?
      flash[:danger] = "Inicie session"
      redirect_to login_path
    end
  end

end