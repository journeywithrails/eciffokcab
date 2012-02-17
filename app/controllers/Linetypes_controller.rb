class LinetypesController < ApplicationController
  # GET /linetypes
  # GET /linetypes.xml
  def index
    @linetypes = Linetype.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @linetypes }
    end
  end

  # GET /linetypes/1
  # GET /linetypes/1.xml
  def show
    @linetype = Linetype.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @linetype }
    end
  end

  # GET /linetypes/new
  # GET /linetypes/new.xml
  def new
    @linetype = Linetype.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @linetype }
    end
  end

  # GET /linetypes/1/edit
  def edit
    @linetype = Linetype.find(params[:id])
  end

  # POST /linetypes
  # POST /linetypes.xml
  def create
    @linetype = Linetype.new(params[:linetype])

    respond_to do |format|
      if @linetype.save
        format.html { redirect_to(@linetype, :notice => 'Linetype was successfully created.') }
        format.xml  { render :xml => @linetype, :status => :created, :location => @linetype }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @linetype.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /linetypes/1
  # PUT /linetypes/1.xml
  def update
    @linetype = Linetype.find(params[:id])

    respond_to do |format|
      if @linetype.update_attributes(params[:linetype])
        format.html { redirect_to(@linetype, :notice => 'Linetype was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @linetype.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /linetypes/1
  # DELETE /linetypes/1.xml
  def destroy
    @linetype = Linetype.find(params[:id])
    @linetype.destroy

    respond_to do |format|
      format.html { redirect_to(linetypes_url) }
      format.xml  { head :ok }
    end
  end
end
