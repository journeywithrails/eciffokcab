class Comment < ActiveRecord::Base
  belongs_to :ticket

after_create :comment_notify

validates_presence_of :body

  def comment_notify
    #if Comment.last.hidden == '0' then
      if Comment.last.hidden == false then CommentsNotifier.notify(self).deliver end
	#end
  end



 def self.return_comments
    find(:all,
     :order => "id DESC"
    )
  end

 def self.return_comments_for_id
    find(params[:id])
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

