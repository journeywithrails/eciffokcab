class Ticket < ActiveRecord::Base
  belongs_to :customer
  has_many :comments
  #validates_presence_of :subject, :referredby
  before_create :set_customer_id

  def self.total_on(date)
    where("date(created_at) = ?", date).count
  end

  def self.getname(customer_id)
    theirname = Customer.where("id = ?", 1)
    return theirname
  end

  def set_customer_id
    #@ticket.customer_id = params[:customer_id]
    #return @ticket.customer_id
  end

  def progress_diagnose
    diagdone = false
    for comment in self.comments do
      if comment.subject == "Diagnosis" then diagdone = "true" else "" end
    end
    return diagdone
  end

  def progress_approval
    ticket_approval = false
    for comment in self.comments do
      if comment.subject == "Approval" then ticket_approval = "true" else "" end
    end
    if self.isapproved == true then ticket_approval = "true" else "" end
    return ticket_approval
  end

  def progress_completed
    ticket_complete = false
    for comment in self.comments do
      if comment.subject == "Completed" then ticket_complete = "true" else "" end
    end
    return ticket_complete
  end

  def self.return_tickets
    find(:all,
         :order => "id DESC"
    )
  end


end

# == Schema Information
#
# Table name: tickets
#
#  id             :integer         primary key
#  customer_id    :integer         not null
#  number         :string(255)
#  subject        :string(255)
#  status         :string(255)
#  problem_type   :string(255)
#  created_at     :timestamp
#  updated_at     :timestamp
#  category       :string(20)      not null
#  referredby     :string(25)
#  removeav       :boolean         not null
#  isapproved     :boolean         not null
#  memory         :integer
#  upgradeoffered :boolean         default(FALSE)
#  password       :string(35)
#  cancelled      :boolean
#

