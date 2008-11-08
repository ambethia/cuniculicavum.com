class TopicsController < ApplicationController

  before_filter :find_topic,        :only => [:edit, :update, :destroy, :show]
  before_filter :require_ownership, :only => [:edit, :update, :destroy]  

  # GET /topics
  # GET /topics.xml
  def index
    @topics = Topic.paginate :per_page => 3, :page => params[:page]

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @topics }
    end
  end

  # GET /topics/1
  # GET /topics/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @topic }
    end
  end

  # GET /topics/new
  # GET /topics/new.xml
  def new
    @topic = Topic.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @topic }
    end
  end

  # GET /topics/1/edit
  def edit
  end

  # POST /topics
  # POST /topics.xml
  def create
    @topic = Topic.new(params[:topic])
    @topic.author = current_user

    respond_to do |format|
      if @topic.save
        flash[:notice] = "Topic was successfully created."
        format.html { redirect_to(@topic) }
        format.xml  { render :xml => @topic, :status => :created, :location => @topic }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @topic.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /topics/1
  # PUT /topics/1.xml
  def update
    respond_to do |format|
      if @topic.update_attributes(params[:topic])
        flash[:notice] = "Topic was successfully updated."
        format.html { redirect_to(@topic) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @topic.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.xml
  def destroy
    @topic.destroy

    respond_to do |format|
      format.html { redirect_to(topics_url) }
      format.xml  { head :ok }
    end
  end

  private

    def find_topic
      @topic = Topic.find(params[:id])
    end

    def require_ownership
      unless @topic.author == current_user
        flash[:warning] = "You are not the owner of this topic."
        redirect_to(@topic)
      end
    end

end
