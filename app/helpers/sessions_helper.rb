module SessionsHelper

  def sign_in(user)
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
  
  def sign_out
    #1: cookies.delete(:remember_token)
    cookies.delete(:permanent_token)
    self.current_user = nil
  end
  
  private
  
    def user_from_remember_token
      #puts cookies.signed[:permanent_token].inspect
      User.authenticate_with_salt(*remember_token)
    end
    
    def remember_token
      #1: cookies.signed[:remember_token] || [nil, nil] 
      cookies.signed[:permanent_token] || [nil, nil]
    end
  
end
