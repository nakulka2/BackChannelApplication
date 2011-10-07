class VotesController < ApplicationController
  # GET /votes
  # GET /votes.xml
  def index
    @votes = Vote.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @votes }
    end
  end

  # GET /votes/1
  # GET /votes/1.xml
  def show
    @vote = Vote.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @vote }
    end
  end

  # GET /votes/new
  # GET /votes/new.xml
  def new
   if current_user==nil
     flash[:message]="you need to login"
      redirect_to(:controller => "posts",:action => 'index')
   else
   @vote = Vote.new
   puts params[:vtype]
   if params[:vtype]=="p"
   @post=Post.find(params[:pr_id])
   if current_user.id!=@post.user_id && !Vote.exists?(:voter=>current_user.username, :pr_id=>params[:pr_id],
   :vtype=>"p")
   @vote.pr_id=params[:pr_id]
   @vote.vtype=params[:vtype]
   @vote.voter=current_user.username
   @vote.save
   @post.vcount=Vote.count(:pr_id,:conditions => ['pr_id = ? AND vtype = ?', @post.id,"p" ])
   @replies=Reply.find_all_by_post_id(@post.id)
       r_count=0;
       @replies.each do |r|
         r_count+=r.vcount
         end
   @post.vcount+=r_count
   @post.update_attributes(params[:post])
   end
   end

   if params[:vtype]=="r"
     @reply=Reply.find(params[:pr_id])
     if current_user.id!=@reply.user_id && !Vote.exists?(:voter=>current_user.username, :pr_id=>params[:pr_id],
     :vtype=>"r")
     @vote.pr_id=params[:pr_id]
     @vote.vtype=params[:vtype]
     @vote.voter=current_user.username
     @vote.save
     @reply.vcount=Vote.count(:pr_id,:conditions => ['pr_id = ? AND vtype = ?', @reply.id,"r" ])
     @reply.update_attributes(params[:reply])
     @post=Post.find(@reply.post_id)
     @post.vcount+=1
     @post.update_attributes(params[:post])


     end
   end

   redirect_to(:controller=>"posts",:action=>:"index")
   end
   end

  # GET /votes/1/edit
  def edit
    @vote = Vote.find(params[:id])
  end

  # POST /votes
  # POST /votes.xml
  def create
    @vote = Vote.new

    respond_to do |format|
      if @vote.save
        format.html { redirect_to(@vote, :notice => 'Vote was successfully created.') }
        format.xml  { render :xml => @vote, :status => :created, :location => @vote }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @vote.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /votes/1
  # PUT /votes/1.xml

  def update_votes
     @vote = Vote.new(params[:vote])
  end
  def update
    @vote = Vote.find(params[:id])

    respond_to do |format|
      if @vote.update_attributes(params[:vote])
        format.html { redirect_to(@vote, :notice => 'Vote was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @vote.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /votes/1
  # DELETE /votes/1.xml
  def destroy
    @vote = Vote.find(params[:id])
    @vote.destroy

    respond_to do |format|
      format.html { redirect_to(votes_url) }
      format.xml  { head :ok }
    end
  end
end
