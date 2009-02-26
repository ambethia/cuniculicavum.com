class RegistrationsController < ApplicationController
  before_filter :find_event
  
  # GET /registrations/1
  # GET /registrations/1.xml
  def show
    @registration = @event.registrations.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @registration }
    end
  end

  # GET /registrations/new
  # GET /registrations/new.xml
  def new
    @registration = @event.registrations.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @registration }
    end
  end

  # GET /registrations/1/edit
  def edit
    @registration = @event.registrations.find(params[:id])
  end

  # POST /registrations
  # POST /registrations.xml
  def create
    @registration = @event.registrations.new(params[:registration])

    respond_to do |format|
      if @registration.save
        flash[:notice] = 'Registration was successfully created.'
        format.html { redirect_to(@event) }
        format.xml  { render :xml => @registration, :status => :created, :location => @registration }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @registration.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /registrations/1
  # PUT /registrations/1.xml
  def update
    @registration = @event.registrations.find(params[:id])

    respond_to do |format|
      if @registration.update_attributes(params[:registration])
        flash[:notice] = 'Registration was successfully updated.'
        format.html { redirect_to(@event) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @registration.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /registrations/1
  # DELETE /registrations/1.xml
  def destroy
    @registration = @event.registrations.find(params[:id])
    @registration.destroy

    respond_to do |format|
      format.html { redirect_to(@event) }
      format.xml  { head :ok }
    end
  end
  
  private
  
    def find_event
      @event = Event.find(params[:event_id])
    end
end
