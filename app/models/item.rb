class Item < ActiveRecord::Base
	scope :last_six_days, :conditions => { :requestedon => Time.now-6.day..Time.now }
	#named_scope :has_price, :conditions => "items.price > 1"
	scope :has_price, :conditions => [ 'price > ?', '1.01' ]

	
	
	def self.return_items
	find(:all,
		:order => "id DESC",
		:conditions => ""
	)
	end

  after_create :part_notify

  def part_notify
    PartsNotifier.notify(self).deliver
  end  
  
  def self.recent_parts_orders_subtotal
  recent_orders = Item.last_six_days
  	recentsub = 0
    recent_orders.each do |item|
    recentsub = recentsub + item.price
    end 
	return recentsub
  end
	
end

# == Schema Information
#
# Table name: items
#
#  id          :integer         primary key
#  requestedon :timestamp
#  ticketnum   :string(8)       not null
#  parturl     :string(300)
#  shipping    :string(20)
#  deststore   :string(20)
#  orderedby   :string(30)
#  orderedon   :date
#  trackingnum :string(25)
#  receivedon  :date
#  price       :decimal(, )     default(0.0), not null
#

