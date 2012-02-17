require 'fastercsv'

class InvoicesController < ApplicationController
  before_filter :authenticate_user! #, :except => [:index]

  # GET /invoices
  # GET /invoices.xml
  def index
    @invoices = Invoice.number_like_all(params[:search].to_s.split).descend_by_id.paginate(:page => params[:page], :per_page => 20)
    #@customers = Customer.all #test?
    #@invoices = Invoice.all.paginate :page => params[:page], :per_page => 10
#    @invoices = Invoice.search("number LIKE ?", "%#{params[:search]}%") #testing search
    @search = Invoice.search(params[:search])
    ##@invoices = @search.all  #.paginate :page => params[:page], :per_page => 10
    #@search = Customer.search(params[:search])
    #@customers = @search.all.paginate :page => params[:page], :per_page => 10


    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @invoices }
    end
  end

  # GET /invoices/1
  # GET /invoices/1.xml
  def show
    @invoice = Invoice.find(params[:id])
    @line_item = LineItem.new
    @customer = Customer.find_by_id(params[:customer_id]) #pre de-nesting - for prawn
    @thiscustomer = Customer.where("id = ?", @invoice.customer_id)
    #2 exampls of searches
    #@open_tickets = Ticket.where("status != 'Resolved'")
    #@resolved_tickets = Ticket.where("status = 'Resolved'")
    @related_ticket = Ticket.where("id = ?", @invoice.ticket_id)
    #@ticket = Ticket.find(params[:customer_id]) #got ticket detail to render, seems to be unnec.
    #@comments = Comment.find_all_by_id(params[:customer_id])
    @comments = Comment.where("ticket_id = ? AND hidden != '1'", @invoice.ticket_id)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @invoice }
      format.pdf  { render :layout => false }
      format.csv do
        @invoicesdump = Invoice.find(:all, :order => "id DESC")
        @outfile = "invoice_dump_" + Time.now.strftime("%m-%d-%Y") + ".csv"

        csv_data = FasterCSV.generate do |csv|
          csv << [
              "ID",
              "Customer_ID",
              "Tech",
              "PaymentType",
              "Invoice Number",
              "Subtotal",
              "Tax",
              "paid",
              "date",
              "received_on",
              "Location"
          ]
          @invoicesdump.each do |invoice|
            csv << [
                invoice.id,
                invoice.customer_id,
                invoice.employee,
                invoice.payment_type,
                invoice.number,
                invoice.subtotal,
                invoice.tax,
                invoice.paid,
                invoice.date,
                invoice.date_received,
                invoice.category
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


  # GET /invoices/new
  # GET /invoices/new.xml
  def new
    @customer = Customer.find_by_id(params[:customer_id])
    @invoice = Invoice.new
    @invoice.customer_id = @customer.id
    @ticket = Ticket.find_by_id(params[:ticket_id])
    @last_invoice = Invoice.last
    #@invoice.ticket_id = params[:invoice_id].to_i if params[:invoice_id]


    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @invoice }
    end
  end

  # GET /invoices/1/edit
  def edit
    @invoice = Invoice.find(params[:id])
  end

  # POST /invoices
  # POST /invoices.xml
  def create
    @customer = Customer.find_by_id(params[:customer_id])
    #@customer = Customer.find_by_id(@invoice.customer_id)
    @invoice = Invoice.new(params[:invoice])
    #@invoice.customer_id = @customer.id
    if @invoice.category.nil? then @invoice.category = "Redmond" end
    if @invoice.paid.nil? then @invoice.paid = false end

    @invoice.timestamp = Time.now
    @invoice.date = Time.now
    @invoice.employee = current_user.email
    #@invoice.ticket_id = params[:invoice_id].to_i if params[:invoice_id]


    respond_to do |format|
      if @invoice.save
        format.html { redirect_to(invoice_path(@invoice.id), :notice => 'Invoice was successfully created.') }
        format.xml  { render :xml => @invoice, :status => :created, :location => @invoice }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @invoice.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /invoices/1
  # PUT /invoices/1.xml
  def update
    @invoice = Invoice.find(params[:id])
    @invoice.timestamp = Time.now
    @invoice.update_totals


#    #if the invoice is paid, let's add them to the email marketing list
#    if @invoice.paid = true then
#      @cust = Customer.find_by_id(@invoice.customer_id)
#      url = "http://allinnetworks.com/index.php?option=com_acymailing&gtask=sub&task=optin&hiddenlists=1,8&user[email]=" + @cust.email + "&user[name]=" + @cust.firstname + " " + @cust.lastname
#      @doc = Nokogiri::XML(open(url))
#    end


    respond_to do |format|
      if @invoice.update_attributes(params[:invoice])
        format.html { redirect_to(invoice_path(@invoice.id), :notice => 'Invoice was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @invoice.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /invoices/1
  # DELETE /invoices/1.xml
  def destroy
    @invoice = Invoice.find(params[:id])

    @customer = Customer.find_by_id(params[:customer_id])
    #@invoice.customer_id = @customer.id



    @invoice.destroy

#    respond_to do |format|
#      format.html { redirect_to (customer_path(@invoice.customer_id), :notice => 'Invoice was successfully deleted.') }
#      format.xml  { head :ok }
#    end
  end

  def email_invoice

    invoice = Invoice.find(params[:id])
    customer = Customer.find(invoice.customer_id)

    template = File.read("#{RAILS_ROOT}/app/views/invoices/show.pdf.prawn")
    pdf = Prawn::Document.new(:page_size => 'A4')
      
    pdf.instance_eval do
            @invoice = invoice
    	    @customer = customer
            @line_item = LineItem.new
            @thiscustomer = Customer.where("id = ?", @invoice.customer_id)
            @related_ticket = Ticket.where("id = ?", @invoice.ticket_id)
            @comments = Comment.where("ticket_id = ? AND hidden != '1'", @invoice.ticket_id) #put here, all local variables that the pdf template needs
        eval(template) #this evaluates the template with your variables
    end
    attachment = pdf.render


    @invoice = Invoice.find(params[:id])
    @customer = Customer.find(@invoice.customer_id)

    CustomerMailer.notify(attachment,@invoice,@customer).deliver
    redirect_to(request.referer)
  end

end
