class CommentsNotifier < ActionMailer::Base
  #default :from => "no-reply@drpcfix.com"

  def notify(comment)
    @comment = comment
	@thisticket = Ticket.find_by_id(@comment.ticket_id)
	@thiscustomer = Customer.find_by_id(@thisticket.customer_id)
    mail( :to => @thiscustomer.email, :cc => @comment.tech, :from => @comment.tech, :reply_to => "techs-reply@drpcfix.com" , :subject => 'Dr PC Fix - Comment made to ticket number ' + @comment.ticket_id.to_s)

  end

end
