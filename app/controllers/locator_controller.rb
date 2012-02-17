class LocatorController < ApplicationController
  before_filter :authenticate_user! #, :except => [:index]

  def index
    @json = Customer.all.to_gmaps4rails
    #   google map json manually
#    @json = '[
#             {"description": "test", "title": "test", "sidebar": "test", "longitude": "-122.22", "latitude": "47.12", "picture": "", "width": "", "height": ""},
#             {"longitude": "-122.22", "latitude": "47.12" }
#            ]'

  end

end
