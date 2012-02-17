require 'test_helper'

class LineItemTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
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

