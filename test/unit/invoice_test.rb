require 'test_helper'

class InvoiceTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
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

