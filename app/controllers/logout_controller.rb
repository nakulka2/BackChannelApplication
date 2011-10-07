class LogoutController < ApplicationController
def index
  if current_user.id!=nil
 session[:current_user_id]=nil
    redirect_to posts_path
end
end
end
