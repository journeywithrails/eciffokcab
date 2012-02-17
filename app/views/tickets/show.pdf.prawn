require 'prawn/layout' 

 logo = "public/images/logo.png"
 #imagepaid = "public/images/paid.png"

pdf.image logo, :position => :left,   :vposition => :top


pdf.move_down(10) 

@thiscustomer.each do |customer|

pdf.text  "Customer: #{customer.firstname} #{customer.lastname}"
   pdf.text "Email: #{customer.email}"
   pdf.text "Address: #{customer.address}"
   pdf.text "City/State/Zip: #{customer.city}, #{customer.state} #{customer.zip}"
   pdf.text "Phone: #{number_to_phone(customer.phone)}"


end


customer = @thiscustomer.map do |customer|
  [
    customer.firstname,
    customer.lastname,
    customer.email,
    customer.city,
    customer.phone,
  ]
end
  

# this floats off to side - /1.5 means more than .5 to the right
 pdf.float do
    pdf.bounding_box [pdf.bounds.width / 1.5, pdf.bounds.top], :width => 300 do

      pdf.move_down(10)
      pdf.text "Ticket Number: #{@ticket.id }"
      pdf.text   "Created: #{I18n.l @ticket.created_at} "

      #footer floating
      pdf.move_down(10)

    end
  end


pdf.move_down(20) 

 
pdf.text  "Ticket Summary"

pdf.move_down(20)

pdf.text ("Subject: " + @ticket.subject)
pdf.text ("Problem Type: " + @ticket.problem_type + " Location: " + @ticket.category)
approvalstring = "not yet"
if @ticket.isapproved == true then approvalstring = "yes" end
pdf.text ("Approved: " + approvalstring)

pdf.move_down(30)

pdf.text  "Ticket Details"


pdf.move_down(10)

ticketme = @ticketobj.map do |ticket|
  [
    ticket.id,
    ticket.created_at,
    ticket.subject,
    ticket.category,
    ticket.problem_type,
  ]
end


pdf.table ticketme, :border_style => :grid,
  :column_widths => { 0 => 25 , 1 => 175, 2 => 190, 3 => 65, 4 => 90},
  :row_colors => ["FFFFFF","DDDDDD"],
  :headers => ["ID", "Created", "Subject", "Location", "Problem Type"],
  :align => { 0 => :left, 1 => :left, 2 => :left, 3 => :left, 4 => :left}
 

comments = @mycomments.map do |comments|
  [
    comments.created_at,
    comments.tech,
    comments.subject,
    comments.body.gsub!(/(<[^>]*>)|\n|\t/s) {" "},
  ]
end

pdf.table comments, :border_style => :grid,
  :column_widths => { 0 => 160 , 1 => 115, 2 => 80, 3 => 200},
  :row_colors => ["FFFFFF","DDDDDD"],
  :headers => ["Date", "Tech", "Subject", "Comment"],
  :align => { 0 => :left, 1 => :left, 2 => :left, 3 => :left}

