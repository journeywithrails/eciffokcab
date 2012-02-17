class Customer < ActiveRecord::Base

  validates_uniqueness_of :email
  validates_presence_of :email, :phone

  has_many :invoices
  has_many :upgrades

  cattr_reader :per_page
  @@per_page = 10

  geocoded_by :address_pack
    def address_pack
    [address, city, state].compact.join(', ')
    end

  after_validation :geocode, :if => :address_changed?

  acts_as_gmappable :process_geocoding => false
    def gmaps4rails_title
    self.email
  end

  def gmaps4rails_infowindow
   "<strong>" + "Some Text!" + "</strong>" + "<br><br>"  + "<br>"  + "<br>"
  end


  def to_s
  end

  def self.return_invoices
    find(:all)
  end

  def self.return_tickets
    find(:all)
  end


  def self.return_recent_customers
    find(:all,
         :order => "id DESC",
         :limit => 5
    )
  end

  def self.business_email
    is_biz = true
    if self.email.include?("hotmail") then is_biz = false end
    if self.email.include?("gmail") then is_biz = false end
    if self.email.include?("aol") then is_biz = false end
    if self.email.include?("yahoo") then is_biz = false end
    if self.email.include?("msn") then is_biz = false end
    if self.email.include?("comcast") then is_biz = false end
    if self.email.include?("frontier") then is_biz = false end
    if self.email.include?("verizon") then is_biz = false end


    return is_biz

  end

end

# == Schema Information
#
# Table name: customers
#
#  id        :integer         primary key
#  firstname :string(36)      not null
#  lastname  :string(36)      not null
#  email     :string(156)     not null
#  address   :string(255)     not null
#  city      :string(56)      not null
#  state     :string(2)       not null
#  zip       :string(10)      not null
#  phone     :string(10)      not null
#  mobile    :string(10)      not null
#  latitude  :float
#  longitude :float
#

