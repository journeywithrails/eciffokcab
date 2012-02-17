require 'test_helper'

class CustomerTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
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

