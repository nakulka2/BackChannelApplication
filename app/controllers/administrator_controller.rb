class AdministratorController < ApplicationController
  def index
    if current_user.nil?
      redirect_to posts_path
    end
  end

end
