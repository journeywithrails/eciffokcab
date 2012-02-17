class LineItem < ActiveRecord::Base
  belongs_to :invoice
#  validates :name, :presence => true
  scope :bizx, :conditions => { :name => 'bizx' }


# to run during the 'create line item' process - to calc totals after each create
  after_create :update_invoice
  after_destroy :update_invoice


  def update_invoice
    self.invoice.update_totals
  end
  
  

# to intercept the update method too - not used atm
  def before_update
#    @line_item.name = "foo"
  end
  

  

  def getsubtotal
    sumcount = 0
    return  line_item.name
  end

  def calculate_totals
    taxrate = 0.095
    @invoice.tax = @invoice.getsubtotal * taxrate
    @invoice.subtotal = @invoice.getsubtotal
    @invoice.total = @invoice.subtotal + @invoice.tax
  end




end



# == Schema Information
#
# Table name: line_items
#
#  id         :integer         primary key
#  invoice_id :integer         default(0), not null
#  item       :text            not null
#  name       :string(156)     not null
#  cost       :decimal(, )     default(0.0), not null
#  price      :decimal(, )     default(0.0), not null
#  quantity   :decimal(, )     default(0.0), not null
#  foobardel  :string(55)
#

