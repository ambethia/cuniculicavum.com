class RepliesController < ApplicationController
  before_filter :find_reply,        :only => [:edit, :update, :destroy, :show]
  before_filter :require_ownership, :only => [:edit, :update, :destroy]
  
  # GET /topics/1/replies
  # GET /topics/1/replies.xml
  def index
    @topic   = Topic.find(params[:topic_id])
    @replies = @topic.replies

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @replies }
    end
  end

  # GET /topics/1/replies/1
  # GET /topics/1/replies/1.xml
  def show
    @topic = Topic.find(params[:topic_id])
    @reply = @topic.replies.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @reply }
    end
  end

  # GET /topics/1/replies/new
  # GET /topics/1/replies/new.xml
  def new
    @topic = Topic.find(params[:topic_id])
    @reply = @topic.replies.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @reply }
    end
  end

  # GET /topics/1/replies/1/edit
  def edit
    @topic = Topic.find(params[:topic_id])
    @reply = @topic.replies.find(params[:id])
  end

  # POST /topics/1/replies
  # POST /topics/1/replies.xml
  def create
    @topic = Topic.find(params[:topic_id])
    @reply = @topic.replies.new(params[:reply])
    @reply.author = current_user

    respond_to do |format|
      if @reply.save
        flash[:notice] = 'Reply was successfully created.'
        format.html { redirect_to(@topic) }
        format.xml  { render :xml => @reply, :status => :created, :location => [@topic, @reply] }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @reply.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /topics/1/replies/1
  # PUT /topics/1/replies/1.xml
  def update
    @topic = Topic.find(params[:topic_id])
    @reply = @topic.replies.find(params[:id])

    respond_to do |format|
      if @reply.update_attributes(params[:reply])
        flash[:notice] = 'Reply was successfully updated.'
        format.html { redirect_to(@topic) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @reply.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/1/replies/1
  # DELETE /topics/1/replies/1.xml
  def destroy
    @reply.destroy

    respond_to do |format|
      format.html { redirect_to(@topic) }
      format.xml  { head :ok }
    end
  end

  private

    def find_reply
      @topic = Topic.find(params[:topic_id])
      @reply = @topic.replies.find(params[:id])
    end

    def require_ownership
      unless @reply.author == current_user
        flash[:warning] = "You are not the owner of this reply."
        redirect_to(@topic)
      end
    end

end
