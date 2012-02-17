class CustomerMailer < ActionMailer::Base
  default :from => "no-reply@drpcfix.com"

  def notify(file,invoice,customer)
    @customer = customer
    @invoice = invoice
    attachments["#{invoice.id}.pdf"] = file
    mail( :to => "#{customer.email}", :subject => 'Invoice for Dr. PC Fix')


  end

end
