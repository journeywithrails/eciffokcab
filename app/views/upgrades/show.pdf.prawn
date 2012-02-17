require 'prawn/layout'

 logo = "public/images/logo.png"
 #imagepaid = "public/images/paid.png"

pdf.image logo, :position => :left,   :vposition => :top

#if @invoice.paid == true then
# pdf.image imagepaid,
# :position => :center,
# :vposition => :top,
# :width => 200,
# :height => 122
#end

pdf.move_down(10)
#
#@thiscustomer.each do |customer|
#
#pdf.text  "Customer: #{customer.firstname} #{customer.lastname}"
#   pdf.text "Email: #{customer.email}"
#   pdf.text "Address: #{customer.address}"
#   pdf.text "City/State/Zip: #{customer.city}, #{customer.state} #{customer.zip}"
#   pdf.text "Phone: #{number_to_phone(customer.phone)}"
#
#
#end


#customer = @thiscustomer.map do |customer|
#  [
#    customer.firstname,
#    customer.lastname,
#    customer.email,
#    customer.city,
#    customer.phone,
#  ]
#end

#pdf.table customer, :border_style => :grid,
#  :row_colors => ["FFFFFF","DDDDDD"],
#  :headers => ["ID", "Created", "Subject", "Location", "Problem Type"],
#  :align => { 0 => :left, 1 => :left, 2 => :left, 3 => :left, 4 => :left},
#  :width => 200


## this floats off to side - /1.5 means more than .5 to the right
# pdf.float do
#    pdf.bounding_box [pdf.bounds.width / 1.5, pdf.bounds.top], :width => 300 do
#
#      pdf.move_down(10)
#      pdf.text   "Recommendation Date:    #{@upgrade.date} "
#
#      #footer floating
#      pdf.move_down(10)
#      pdf.text "Subtotal: #{@upgrade.memory}", :size => 16, :style => :bold
#      pdf.text "Tax: #{number_to_currency(@invoice.tax)}", :size => 16, :style => :bold
#      pdf.text "Invoice Total: #{number_to_currency(@invoice.total)}", :size => 16, :style => :bold
##      pdf.text "tax: #{@invoice.tax}"
##      pdf.text "Subtotal: #{@invoice.subtotal}"
##      pdf.text "Total: #{@invoice.total}"
#
#
#    end
#  end


pdf.move_down(20)


pdf.text  "Upgrade Summary"

pdf.move_down(20)


#items = @invoice.line_items.map do |item|
#  [
#    item.item,
#    item.name,
#    item.quantity,
#    number_to_currency(item.price),
#    number_to_currency(item.price * item.quantity),
#  ]
#end
#
#pdf.table items, :border_style => :grid,
#  :row_colors => ["FFFFFF","DDDDDD"],
#  :headers => ["Item", "Product", "Qty", "Unit Price", "Full Price"],
#  :align => { 0 => :left, 1 => :left, 2 => :left, 3 => :left, 4 => :left},
#  :width => 500


pdf.move_down(30)

#pdf.text  "Ticket Details"
#
#
#pdf.move_down(10)
#
#if @invoice.ticket_id != nil then
#
#ticket = @related_ticket.map do |ticket|
#  [
#    ticket.id,
#    ticket.created_at,
#    ticket.subject,
#    ticket.category,
#    ticket.problem_type,
#  ]
#end
#
#pdf.table ticket, :border_style => :grid,
#  :column_widths => { 0 => 45 , 1 => 165, 2 => 190, 3 => 65, 4 => 90},
#  :row_colors => ["FFFFFF","DDDDDD"],
#  :headers => ["ID", "Created", "Subject", "Location", "Problem Type"],
#  :align => { 0 => :left, 1 => :left, 2 => :left, 3 => :left, 4 => :left},
#  :width => 500
#
#comments = @comments.map do |comments|
#  [
#    comments.created_at,
#    comments.subject,
#    comments.tech,
#    comments.body.gsub!(/(<[^>]*>)|\n|\t/s) {" "},
#
#  ]
#end

#pdf.table comments, :border_style => :grid,
#  :row_colors => ["FFFFFF","DDDDDD"],
#  :headers => ["Date", "Subject", "Tech", "Comment"],
#  :align => { 0 => :left, 1 => :left, 2 => :left, 3 => :left},
#  :width => 500

#
#@comments.each do |comment|
# pdf.move_down(10)
#pdf.text "Update Type: #{comment.subject} | Date: #{I18n.l comment.created_at} | Tech: #{comment.tech}"
#
#pdf.move_down(10)
#pdf.text "Message: #{comment.body}"
#pdf.move_down(10)
#
#pdf.text "------------------------------------------------------------------------------------------------------------------"
#
#end
#
#else
#
#pdf.text "No related Ticket"
#
#end

# this floats off to side - /1.5 means more than .5 to the right
 #pdf.float do
 #   pdf.bounding_box [pdf.bounds.width / 20, pdf.bounds.top], :width => 500 do

      #footer floating
      #pdf.move_down(640)
      #pdf.text "Return Policy and Warranty Information:", :size => 9, :style => :bold
	  #pdf.move_down(4)
	  #pdf.text "All purchases come with a 7-day return policy from the date of the original invoice and must be returned complete with all original packaging. Some returns may incur a restocking fee determined at the time of the return. Most items do come with a 1 year manufacturer warranty unless it is a refurbished item. If there is a manufacturer warranty you must contact them for warranty repair or replacement. ", :size => 7
	  #pdf.move_down(4)
	  #pdf.text "The following items are not returnable: Software, Printers, Scanners, Ink Cartridges, toner, refurbished laptops.", :size => 7
	  ##pdf.move_down(4)
	  #pdf.text "All computer systems built by Dr PC Fix with our logo sticker on them have a 1 year parts warranty, and 3 years labor. If anyone besides Dr PC Fix works on the machine the warranty is no longer valid. ", :size => 7
	  #pdf.move_down(2)
	  #pdf.text "Dr PC Fix, LLC | 13501 100th AVE NE, Suite 10 | Kirkland WA 98034 | 425-825-0222 | www.drpcfix.com", :size => 7

    #end
  #end

