class PartsNotifier < ActionMailer::Base
  default :from => "no-reply@drpcfix.com"

  def notify(item)
    @item = item
    mail( :to => 'ben@drpcfix.com', :subject => 'Parts Order -'+ @item.ticketnum)

  end

end
