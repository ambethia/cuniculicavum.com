class CharactersController < ApplicationController
  skip_before_filter :require_activation, :only => [:new, :create, :edit, :update]
  before_filter :find_character,    :only => [:edit, :update, :destroy, :show]
  before_filter :require_ownership, :only => [:edit, :update, :destroy]  
  
  
  # GET /characters
  # GET /characters.xml

  def index
    @characters = Character.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @characters }
    end
  end

  # GET /characters/1
  # GET /characters/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @character }
    end
  end

  # GET /characters/new
  # GET /characters/new.xml
  def new
    @character = current_user.characters.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @character }
    end
  end

  # GET /characters/1/edit
  def edit
  end

  # POST /characters
  # POST /characters.xml
  def create
    @character = current_user.characters.new(params[:character])

    respond_to do |format|
      if @character.save
        flash[:notice] = 'Character was successfully created.'
        format.html { redirect_to(current_user_path) }
        format.xml  { render :xml => @character, :status => :created, :location => @character }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @character.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /characters/1
  # PUT /characters/1.xml
  def update
    respond_to do |format|
      if @character.update_attributes(params[:character])
        flash[:notice] = 'Character was successfully updated.'
        format.html { redirect_to(@character) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @character.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /characters/1
  # DELETE /characters/1.xml
  def destroy
    @character.destroy

    respond_to do |format|
      format.html { redirect_to(characters_url) }
      format.xml  { head :ok }
    end
  end
  
  private

    def find_character
      @character = Character.find(params[:id])
    end

    def require_ownership
      unless current_user.officer? || @character.user == current_user
        flash[:warning] = "You are not the owner of this character."
        redirect_to(@character)
      end
    end
end
