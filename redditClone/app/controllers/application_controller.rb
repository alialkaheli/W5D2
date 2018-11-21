class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in

  def current_user
    @current_user ||= find_by(session_token: session[:session_token])
  end

  def logged_in
    !!current_user
  end

  def login(user)
    @current_user = user
    session[:session_token] = user.session_token
  end

  def logout
    current_user.reset_token!
    session[:session_token] = nil
  end

  def required_logged_in
    redirect_to new_session_url unless logged_in
  end
end