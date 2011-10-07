class PostsController < ApplicationController
  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all(:order=>('DATE(created_at) desc, vcount desc'))
    if session[:current_user_id] !=nil
    flash[:login_user]= current_user.username+ "  logged in"
      if current_user.user_type=="admin"
        flash[:admin_logged_in]=""
      end
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end
  def search
    @search_string=params[:search_string]
    if params[:stype].nil?
      params[:stype]="content"
    end
    if params[:stype]=="user"
    @user=User.find_by_username(@search_string)
    if(@user!=nil)
    @posts=Post.find_all_by_post_owner(@user.username)
      respond_to do |format|
      format.html # search.html.erb
      format.json { render json: @posts }
      end
    else
      redirect_to posts_path
    end
    elsif params[:stype]=="content"
     qword="SELECT post_owner, question from posts where question like '%"
     qword<<params[:search_string]
     qword<<"%'"
     @questions= Post.find_by_sql(qword)
     qword="SELECT response from replies where response like '%"
     qword<<params[:search_string]
     qword<<"%'"
     @replies= Reply.find_by_sql(qword)

    end

 end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new
    if current_user==nil
          redirect_to(:controller => "login",:action => 'index')
        else

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
      end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(params[:post])
    @post.post_owner=current_user.username
    @post.user_id=current_user.id
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def manage_posts
    @posts = Post.all

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @reply=Reply.find_all_by_post_id(@post.id)
    @reply.each do |r|
      r.destroy
    end
    @post.destroy

    respond_to do |format|
      format.html { redirect_to post_manage_posts_path }
      format.json { head :ok }
    end
  end

end
