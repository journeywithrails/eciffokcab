class CustomersController < ApplicationController
before_filter :authenticate_user! #, :except => [:index]

  # GET /customers
  # GET /customers.xml
  def index
    @invoices = Invoice.number_like_all(params[:searchlogic].to_s.split).paginate(:page => params[:page])
    #@invoices = Invoice.return_recent_invoices
    @search = Customer.search(params[:search])
    @customers = @search.all(:order => "id DESC").paginate :page => params[:page], :per_page => 20
#order("id") before.search-.order(:id)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @customers }
    end
  end

  # GET /customers/1
  # GET /customers/1.xml
  def show
    @customer = Customer.find(params[:id])
    @tickets = Ticket.return_tickets
    @mytickets = Ticket.find_all_by_customer_id(params['id'])
    @myinvoices = Invoice.find_all_by_customer_id(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @customer }
	  format.csv do
  @customersdump = Customer.find(:all, :order => "id DESC")
  @outfile = "customers_dump_" + Time.now.strftime("%m-%d-%Y") + ".csv"
  
  csv_data = FasterCSV.generate do |csv|
    csv << [
    "ID",
    "FirstName",
    "LastName",
    "Email",
    "Address",
    "City",
    "State",
    "Zip",
    "Phone",
    "Mobile",
    ]
    @customersdump.each do |customer|
      csv << [
      customer.firstname,
      customer.lastname,
      customer.email,
      customer.address,
      customer.city,
      customer.state,
      customer.zip,
      customer.phone,
      customer.mobile,
      ]
    end
  end

  send_data csv_data,
    :type => 'text/csv; charset=iso-8859-1; header=present',
    :disposition => "attachment; filename=#{@outfile}"		 
  flash[:notice] = "Export complete!"
  end
	  
    end
  end


  # GET /customers/1 - PRINT TEST
  # GET /customers/1.xml
  def printview
    @customer = Customer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @customer }
    end
  end

  # GET /customers/new
  # GET /customers/new.xml
  def new
    @customer = Customer.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @customer }
    end
  end

  # GET /customers/1/edit
  def edit
    @customer = Customer.find(params[:id])
  end

  # POST /customers
  # POST /customers.xml
  def create
    @customer = Customer.new(params[:customer])

    respond_to do |format|
      if @customer.save
        format.html { redirect_to(@customer, :notice => 'Customer was successfully created.') }
        format.xml  { render :xml => @customer, :status => :created, :location => @customer }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @customer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /customers/1
  # PUT /customers/1.xml
  def update
    @customer = Customer.find(params[:id])

    respond_to do |format|
      if @customer.update_attributes(params[:customer])
        format.html { redirect_to(@customer, :notice => 'Customer was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @customer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /customers/1
  # DELETE /customers/1.xml
  def destroy
    @customer = Customer.find(params[:id])
    @customer.destroy

    respond_to do |format|
      format.html { redirect_to(customers_url) }
      format.xml  { head :ok }
    end
  end
end
