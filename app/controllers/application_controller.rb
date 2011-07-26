class ApplicationController < ActionController::Base
  
  include SessionsHelper
  
  helper :all
  
  protect_from_forgery
  
end
