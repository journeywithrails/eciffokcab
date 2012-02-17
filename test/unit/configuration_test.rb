require 'test_helper'

class ConfigurationTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end

# == Schema Information
#
# Table name: configurations
#
#  id             :integer         primary key
#  taxrate        :integer
#  business_name  :string(255)
#  admin_user     :string(255)
#  admin_pass     :string(255)
#  invoice_footer :text
#  created_at     :timestamp
#  updated_at     :timestamp
#

