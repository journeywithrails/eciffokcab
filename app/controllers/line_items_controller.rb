class LineItemsController < ApplicationController
before_filter :authenticate_user!
#not implemented
  def show

  end

#just for testing
  def index
#       @invoice = Invoice.all
#       @invoice = Invoice.find_by_id(params[1])
#   @line_items = LineItem.all
#   @line_item = LineItem.find_by_id(params[:invoice_id])
#   @invoice = Invoice.find_by_id(params[:invoice_id])
#scope :in_redmond, :conditions => { :category => 'Redmond' }


s_date = (params[:start_date]).to_date if !params[:start_date].blank?
e_date = (params[:end_date]).to_date if !params[:end_date].blank?
p = (params[:paidonly]) if !params[:paidonly].blank?


if !s_date.blank? && !e_date.blank? && !p.blank? && (e_date > s_date)
@lines = LineItem.all(:joins => :invoice, :conditions => { :invoices => { :category => "Redmond", :date => (s_date)..(e_date), :paid => "t" } })
elsif !s_date.blank? && !e_date.blank? && p.blank? && (e_date > s_date)
@lines = LineItem.all(:joins => :invoice, :conditions => { :invoices => { :category => "Redmond", :date => (s_date)..(e_date) } })
else
@lines = LineItem.all(:joins => :invoice, :conditions => { :invoices => { :category => "Redmond" } })
end


  respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @invoice }
	  format.csv do
  
  @outfile = "line_items_dump_" + Time.now.strftime("%m-%d-%Y") + ".csv"
  
  csv_data = FasterCSV.generate do |csv|
    csv << [
    "ID",
	"Invoice_ID",
	"Type",
	"Cost",
    "Price",
    "Quantity"
    ]
    @lines.each do |invoice|
      csv << [
      invoice.id,
      invoice.invoice_id,
	  invoice.item,
      invoice.cost,
      invoice.price,
      invoice.quantity,
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

  def create #create new invoice line item
	@invoice = Invoice.find_by_id(params[:invoice_id])
	@line_item = LineItem.new(params[:line_item])
	@line_item.invoice_id = @invoice.id
	
    if @line_item.item == "Hardware" then
	  if @line_item.cost < 1 then
	    @line_item.name = "--CHANGEME-- HARDWARE MUST HAVE COST"
	  end
	end

	  if @line_item.save 
	
	    redirect_to invoice_path(@invoice.id) #FIXME
	    #redirect_to "/customers/1/invoices/1"
	  else

 	  render :new

	  end
  end


  def new #renders the page that shows the new form
	@invoice = Invoice.find_by_id(params[:invoice_id])
	@line_item = LineItem.new
  end



  def destroy
    @line_item = LineItem.find(params[:id])
    @line_item.destroy
    @invoice = Invoice.find_by_id(params[:invoice_id])


     respond_to do |format|
      format.html { redirect_to(invoice_path(@invoice.id), :notice => 'Line Item was removed.')}
      format.xml  { head :ok }
     end

  end

end
