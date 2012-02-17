class InboundEmailsController < ApplicationController

  self.allow_forgery_protection = false

  def receive

    subject = params[:subject]

    @ticket = Ticket.find_by_id(subject.split("number")[1].to_i)
    if @ticket.id > 1 then
      @comment = Comment.new
      @comment.ticket_id = @ticket.id
      @comment.tech = "customer-reply"
      @comment.hidden = true
      @comment.subject = "Contact"
      temp_body = params[:text]
      if temp_body.split("\n").count > 50 then
        @comment.body = temp_body.split("\n")[0..-50].join("\n")
      else
        @comment.body = temp_body
      end

      @comment.save
      head :ok
    end
    #job = Job.create({
    #  :title => params[:subject],
    #  :details => params[:text],
    #  :user_id => 3,
    #  :disabled => true,
    #  :expiration => 3.months.from_now,
    #})

    puts params[:subject]
    puts "WE GOT EMAIL"

    #if job
    #  head :ok
    #else
    #  head 500
    #end
    head :ok

  end

end
