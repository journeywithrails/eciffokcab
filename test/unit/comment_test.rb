require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end

# == Schema Information
#
# Table name: comments
#
#  id         :integer         primary key
#  ticket_id  :integer         not null
#  subject    :string(255)
#  body       :text
#  tech       :string(255)
#  created_at :timestamp
#  updated_at :timestamp
#  hidden     :boolean         default(FALSE)
#

