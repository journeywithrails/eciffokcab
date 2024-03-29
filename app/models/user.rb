class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,:recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  
 #   def self.find_for_authentication(conditions={})
 #    conditions[:approved] = true
 #    find(:first, :conditions => conditions)
 #  end 
end

# == Schema Information
#
# Table name: users
#
#  id                   :integer         primary key
#  email                :string(255)     not null
#  encrypted_password   :string(128)     not null
#  password_salt        :string(255)     not null
#  reset_password_token :string(255)
#  remember_token       :string(255)
#  remember_created_at  :timestamp
#  sign_in_count        :integer         default(0)
#  current_sign_in_at   :timestamp
#  last_sign_in_at      :timestamp
#  current_sign_in_ip   :string(255)
#  last_sign_in_ip      :string(255)
#  created_at           :timestamp
#  updated_at           :timestamp
#  group                :string(15)      default("Techs"), not null
#

