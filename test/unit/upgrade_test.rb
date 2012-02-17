require 'test_helper'

class UpgradeTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end

# == Schema Information
#
# Table name: upgrades
#
#  id                :integer         primary key
#  pc_desc           :string(255)
#  pc_age            :date
#  operating_system  :string(255)
#  memory            :integer
#  disk_size         :integer
#  disk_used_percent :integer
#  av_software       :string(255)
#  backups           :string(255)
#  customer_id       :integer
#  created_at        :timestamp
#  updated_at        :timestamp
#

