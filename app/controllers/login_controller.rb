class LoginController < ApplicationController
  def index
   if session[:current_user_id]!=nil
     redirect_to posts_path
   else
   session[:current_user_id]=nil
   end
 end

  def create
    @user = User.find_by_username(params[:userName])
    if @user.nil?
      flash[:no_user]="No such user, please register"
      redirect_to login_index_path
    elsif(@user.password==params[:password])
      session[:current_user_id]=@user.id
      if(@user.user_type=="admin")
        redirect_to(:controller => :"administrator", :action => :"index")
      else
        redirect_to posts_path
      end
    else
      flash[:wrong_credentials]="Incorrect credentials, please try again"
      redirect_to login_index_path
    end
  end

  def destroy
    session[:current_user]=nil
    redirect_to login_index_path
  end
end
