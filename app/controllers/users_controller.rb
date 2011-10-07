class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  def index
    @users=User.all :conditions => (current_user ? ["id != ?", current_user.id] : [])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  def stats
    @users=User.all :conditions => (current_user ? ["id != ?", current_user.id] : [])
    @user_posts_count=Array.new
    @user_replies_count=Array.new
    @user_votes_count=Array.new
    @users.each do |u|
      @post_count=Post.find_all_by_user_id(u.id).count
      @reply_count=Reply.find_all_by_user_id(u.id).count
      @vote_count=Vote.find_all_by_voter(u.username).count
      @user_posts_count<<@post_count
      @user_replies_count<<@reply_count
      @user_votes_count<<@vote_count
    end
    respond_to do |format|
      format.html
      format.json { render json: @user }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])
    if !current_user.nil?
      @user.user_type="admin"
    else
      @user.user_type="user"
    end

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    if current_user==nil
      redirect_to posts_path
    end
    @user = User.find(params[:id])
    @post=Post.find_all_by_post_owner(@user.username)
    @post.each do |p|
    @reply2=Reply.find_all_by_post_id(p.id)

    @reply2.each do |r2|
      @vote1=Vote.find(:all, :conditions => ["pr_id=? and vtype=?",r2.id,"r"])

      @vote1.each do |v|
        v.destroy
      end
      r2.destroy
    end
         @vote2=Vote.find(:all, :conditions => ["pr_id=? and vtype=?",p.id,"p"])
             #find_all_by_vtype_and_by_pr_id("p",p.id)
      @vote2.each do |v|
        v.destroy
      end
    p.destroy
    end
    @reply1=Reply.find_all_by_user_id(@user.id)
    @reply1.each do |r|
      @vote1=Vote.find(:all, :conditions=>["pr_id=? and vtype=?",r.id,"r"])
      @vote1.each do |v|
        v.destroy
      end
      r.destroy
    end
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :ok }
    end
 end
 end
