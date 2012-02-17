class Invoice < ActiveRecord::Base
  belongs_to :customer
  has_many :line_items

  scope :in_redmond, :conditions => { :category => 'Redmond' }
  scope :over_six_months, where("invoice.date <= ?", Time.now-6.month)
  scope :ten_days, lambda { where("date > ?", Time.now-10.day) }
  scope :bizx, :conditions => { :bizx => true }
  scope :month_to_date, :conditions => { :date => Time.now-(Time.now.day).day..Time.now }

  after_update :subscribe_the_email


  cattr_reader :per_page
  @@per_page = 10

  def fix_unpaid2
    foo = Invoice.all
    foo.each do |i|
      if i.paid == true then i.paid
      else
        i.paid = false
        i.save!
      end
    end
  end

  def subscribe_the_email
    if self.ticket_id.to_i > 10 then
      if self.paid? then
        this_ticket = Ticket.find_by_id(self.ticket_id)
        if this_ticket.status = "Resolved" then
          this_customer = Customer.find_by_id(self.customer_id)
          require 'open-uri'
          url = "http://allinnetworks.com/index.php?option=com_acymailing&amp;gtask=sub&amp;task=optin&amp;hiddenlists=1,8" + "&amp;user[email]=" + this_customer.email + "&amp;user[name]=" + this_customer.firstname.gsub(' ', '-').gsub(/[^\w-]/, '') + "%20" + this_customer.lastname.gsub(' ', '-').gsub(/[^\w-]/, '')
          go_register_them = Nokogiri::HTML(open(url))
          puts go_register_them
        end
      end
    end
  end

  #scope :received_after, lambda {|date| :conditions => ["date_received > ?", Time.now-6.month]}
  # named_scope :received_before, lambda {|date| :conditions => ["date_received < ?", date]}

  def self.unpaid_invoices_subtotal
    subunpaid = 0
    unpaid_invoices_sub = Invoice.where("paid = ?", false)
    #unpaid_invoices_sub = Invoice.paid_like(0)
    unpaid_invoices_sub.each do |invoice|
      subunpaid = subunpaid + invoice.subtotal
    end
    return subunpaid
  end

  def self.month_to_date_subtotal
    sub_this_month = 0
    hardware_amt_this_month = 0
    month_to_date_invoices = Invoice.find(:all, :conditions=> { :date => Time.now-(Time.now.day).day..Time.now})
    month_to_date_invoices.each do |invoice|
      sub_this_month = sub_this_month + invoice.subtotal
      if invoice.hardwarecost? then hardware_amt_this_month = hardware_amt_this_month + invoice.hardwarecost end

    end
    sub_this_month = sub_this_month - hardware_amt_this_month
    return sub_this_month
  end

  def self.month_to_date_bizx_subtotal
    sub_this_month = 0
    hardware_amt_this_month = 0
    month_to_date_invoices = Invoice.month_to_date.bizx
    month_to_date_invoices.each do |invoice|
      sub_this_month = sub_this_month + invoice.subtotal
      if invoice.hardwarecost? then hardware_amt_this_month = hardware_amt_this_month + invoice.hardwarecost end

    end
    sub_this_month = sub_this_month - hardware_amt_this_month
    return sub_this_month
  end

  def self.month_to_date_redmond_subtotal

    subthismonth = 0
    month_to_date_invoices = Invoice.in_redmond.find(:all, :conditions=> {
        :date => Time.now-(Time.now.day).day..Time.now
    })
    month_to_date_invoices.each do |invoice|
      subthismonth = subthismonth + invoice.subtotal
    end
    return subthismonth
  end

  def self.month_to_date_hardware_cost
    sumcount = 0
    #line_items = LineItem.where("invoice_id = ?", self.id)
    for line_items in self.line_items
      sumcount += (line_items.price * line_items.quantity)
    end
    return  sumcount
  end

  def self.subtotal_last_30_days
    sub30 = 0
    last_30d_invoices = Invoice.find(:all, :conditions=> {
        :date => Time.now-1.month..Time.now
    })
    last_30d_invoices.each do |invoice|
      sub30 = sub30 + invoice.subtotal
    end
    return sub30
  end

  def self.last_month_subtotal
    startrange = Time.now-(Time.now.day+30).day
    endrange = Time.now-(Time.now.day).day
    last_month_invoices = Invoice.find(:all, :conditions=> { :date => startrange..endrange})
    sublastmonth = 0
    last_month_invoices.each do |invoice|
      sublastmonth = sublastmonth + invoice.subtotal
    end
    return sublastmonth
  end

  def self.last_month_redmond_subtotal

    startrange = Time.now-(Time.now.day+30).day
    #startrange = "2011-02-01 01:01:01"  #must to_datetime
    endrange = Time.now-(Time.now.day).day
    #endrange = "2011-02-28 23:59:01"  #must to_datetime
    last_month_invoices = Invoice.in_redmond.find(:all, :conditions => { :date => startrange.to_datetime..endrange.to_datetime })
    sublastmonth = 0
    last_month_invoices.each do |invoice|
      sublastmonth = sublastmonth + invoice.subtotal
    end
    return sublastmonth
  end


  def self.two_months_ago_subtotal
    startrange = Time.now-(Time.now.day+60).day
    endrange = Time.now-(Time.now.day+30).day
    two_months_ago_invoices = Invoice.find(:all, :conditions=> { :date => startrange..endrange})
    monthsub = 0
    two_months_ago_invoices.each do |invoice|
      monthsub = monthsub + invoice.subtotal
    end
    return monthsub
  end

  def update_totals

    taxrate = 0.095
    self.subtotal = self.getsubtotal
    self.tax = self.subtotal * taxrate
    self.total = self.subtotal + self.tax
    self.hardwarecost = self.gethardwaresubtotal
    if self.notax == true then self.tax = 0 end
    if self.notax == true then self.total = self.subtotal end
    self.save
  end

  def self.return_invoices
    find(:all,
         :order => "id DESC"
    )
  end

  def self.return_recent_invoices
    find(:all,
         :order => "id DESC",
         :limit => 50
    )
  end

# gets the subtotal number - from the line items and quant
  def getsubtotal
    sumcount = 0
    for line_items in self.line_items
      sumcount += (line_items.price * line_items.quantity)
    end
    return  sumcount
  end

  def gethardwaresubtotal
    sumcount = 0
    for line_items in self.line_items
      sumcount += (line_items.cost * line_items.quantity)
    end
    return  sumcount
  end

  def calculate_totals
    taxrate = 0.095
    @invoice.tax = @invoice.getsubtotal * taxrate
    @invoice.subtotal = @invoice.getsubtotal
    @invoice.total = @invoice.subtotal + @invoice.tax
    if @invoice.notax == true then @invoice.tax = 0 end
    if @invoice.notax == true then @invoice.total = @invoice.subtotal end


  end

  def lastinvoicenum
    invcounter = 0
  end

  def self.search(search)
    if search
      find(:all, :conditions => ['number LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end

#  def settles
#   retstring = "Need To Update"
#    if @invoice.subtotal == @invoice.getsubtotal 
#      then "" 
#    else "Need To Update"  
#    end
#  return retstring
#  end



#end of model
end

# == Schema Information
#
# Table name: invoices
#
#  id                :integer         primary key
#  customer_id       :integer         default(0), not null
#  employee          :string(20)
#  payment_type      :text
#  number            :text            not null
#  labor             :decimal(, )     default(0.0), not null
#  total             :decimal(, )     default(0.0), not null
#  subtotal          :decimal(, )     default(0.0), not null
#  tax               :decimal(, )     default(0.0), not null
#  paid              :boolean
#  date              :date
#  date_received     :date
#  notax             :boolean
#  audit             :integer         default(0), not null
#  timestamp         :timestamp
#  check_number      :integer
#  saved             :integer         default(0)
#  createdstampaudit :timestamp
#  payer_name        :string(100)
#  ticket_id         :integer
#  note              :text
#  category          :string(15)
#  hardwarecost      :decimal(, )
#  bizx              :boolean
#

