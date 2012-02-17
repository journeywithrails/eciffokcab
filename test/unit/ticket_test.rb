require 'test_helper'

class TicketTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
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

