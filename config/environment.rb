# Load the rails application
require File.expand_path('../application', __FILE__)

#require 'action_controller/mime_type' 
Mime::Type.register 'application/pdf', :pdf 

# Initialize the rails application
Backoffice1::Application.initialize!

#Rails::Initializer.run do |config|
#config.time_zone = 'Pacific Time (US & Canada)'

#end
#Formtastic::SemanticFormBuilder.send(:include, Formtastic::DatePicker)
