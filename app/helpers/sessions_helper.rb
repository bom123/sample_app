module SessionsHelper

  def sign_in(user)
    #1:cookies.permanent.signed[:remember_token] = [user.id, user.salt]
    cookies.permanent.signed[:permanent_token] = [user.id, user.salt]
    self.current_user = user
  end

  def signed_in?
    !current_user.nil?
  end
  
  def current_user=(user)
    @current_user = user
  end
  
  def current_user    
    @current_user ||= user_from_remember_token
  end
  
  def current_user?(user)
    user == current_user
  end
  
  def sign_out
    #1:cookies.delete(:remember_token)
    cookies.delete(:permanent_token)
    self.current_user = nil
  end

  def authenticate
    deny_access unless signed_in?
  end
  
  def deny_access
    store_location
    flash[:notice] = "Please sign in to access this page."
    redirect_to signin_path
  end
  
  def redirect_back_or(default)
    redirect_to(session[:redirect_to] || default)
    clear_return_to
  end
  
  private
  
    def user_from_remember_token
      #puts cookies.signed[:permanent_token].inspect
      User.authenticate_with_salt(*remember_token)
    end
    
    def remember_token
      #1:cookies.signed[:remember_token] || [nil, nil] 
      cookies.signed[:permanent_token] || [nil, nil]
    end
    
    def store_location
      session[:redirect_to] = request.fullpath
    end
    
    def clear_return_to
      session[:redirect_to] = nil      
    end
  
end
