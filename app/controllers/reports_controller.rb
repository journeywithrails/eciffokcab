class ReportsController < ApplicationController
  before_filter :authenticate_user!, :except => [:mobile]
  # GET /items
  # GET /items.xml
  def main

    @unpaid_invoices =Invoice.where("paid = ?", false).descend_by_date.paginate(:page => params[:page], :per_page => 400)

    startrange = ((Time.now-(Time.now.day).day)-1.month)+4.day
    endrange = Time.now-(Time.now.day).day

    @last_month_redmond_invoices = Invoice.in_redmond.find(:all, :conditions => { :date => startrange.to_datetime..endrange.to_datetime })
    @tendayscustomers = Customer.joins(:invoices) & Invoice.ten_days
    @this_customer_spent = Customer.find_by_id(12).invoices.sum("subtotal")
    @customers_by_spend = Customer.all.sort_by { |c| c.invoices.sum("subtotal") }.reverse.paginate(:page => params[:spendpage], :per_page => 60)
    @resolved_tickets = Ticket.where("status = 'Resolved'")
    @mtd_bizx_invoices = Invoice.month_to_date.bizx
    if current_user.group != 'Admins' then (redirect_to "/",:notice => 'Ticket was successfully deleted.') end

  end

  def finance

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @items }
    end
  end

  def mobile
    #we want to count open tickets
    @open_tickets = Ticket.where("status != 'Resolved'")

    #we want to see revenue numbers
    render :layout => false

  end

end
