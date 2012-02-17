class TicketsController < ApplicationController
before_filter :authenticate_user!

#  def index
#    @tickets = Ticket.all
#    @customer = Customer.find_by_id(params[:customer_id])
#    respond_to do |format|
#      format.html # index.html.erb
#      format.xml  { render :xml => @tickets }
#    end
#  end

  def index
   @search = Ticket.search(params[:search])

   @tickets = @search.all.paginate :page => params[:page], :per_page => 100
   #@customers = Customer.all

    @open_tickets = Ticket.where("status != 'Resolved'")
    @resolved_tickets = Ticket.where("status = 'Resolved'")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @customers }
    end
  end

  # GET /tickets/1
  # GET /tickets/1.xml
  def show
    @ticket = Ticket.find(params[:id])
#    @resolved_tickets = Ticket.all.where("status != 'Resolved'")
    #@customer = Customer.find_by_id(params[:customer_id]) #pre de-nest
	@thiscustomer = Customer.where("id = ?", @ticket.customer_id)
    @comment = Comment.new
	@ticketobj = Ticket.where("id = ?", @ticket)
	@mycomments = Comment.where("ticket_id = ? AND hidden != '1'", @ticket.id)
	
#    @comments = Comment.search("customer_id LIKE ?", "%#{@customer.id}%") #testing search
#    @comments = Comment.return_comments #   works but shows all
    @comments = Comment.find(params[:id]) #   try more find

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ticket }
	  format.pdf  { render :layout => false }
    end
  end

  # GET /tickets/new
  # GET /tickets/new.xml
  def new
    @customer = Customer.find_by_id(params[:customer_id])
    @ticket = Ticket.new
    @ticket.customer_id = params[:customer_id]
	#@ticket.customer_id = @customer.id #pre-de-nesting


    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ticket }
    end
  end

  # GET /tickets/1/edit
  def edit
    @ticket = Ticket.find(params[:id])
  end

  # POST /tickets
  # POST /tickets.xml
  def create #create new ticket
        @customer = Customer.find_by_id(params[:customer_id]) #pre undoing the nesting
        @ticket = Ticket.new(params[:ticket])
        #@ticket.customer_id = params[:customer_id]
		#@ticket.customer_id = @customer.id #pre unnesting
	@ticket.created_at = Time.now

          if @ticket.save

            redirect_to ticket_path(@ticket.id)
            #redirect_to "/customers/1/tickets/1"
          else

          render :new

          end
  end

  # PUT /tickets/1
  # PUT /tickets/1.xml
  def update
    @ticket = Ticket.find_by_id(params[:id])

    respond_to do |format|
      if @ticket.update_attributes(params[:ticket])

        format.html { redirect_to ticket_path(@ticket.id) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ticket.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tickets/1
  # DELETE /tickets/1.xml
  def destroy
    @ticket = Ticket.find(params[:id])
    @customer = Customer.find_by_id(params[:customer_id])
    @ticket.destroy

    respond_to do |format|
      format.html { redirect_to(tickets_url, :notice => 'Ticket was successfully deleted.') }
      format.xml  { head :ok }
    end
  end
end
