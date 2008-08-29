require 'digest/sha1'

class User < ActiveRecord::Base
  has_many :orders
  
  attr_accessible :first_name, :last_name, :email, :street, :city, :zip, :phone, :password, :password_confirmation
  
  validates_presence_of :first_name, :last_name, :email, :street, :city, :zip, :phone, :password
  validates_uniqueness_of :email
  validates_numericality_of :phone, :zip # TODO: opravdu jen cislo? (zip)
  validates_length_of :phone, :within => 9..9 # TODO: opravdu vzdy 9?
  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
  validates_confirmation_of :password 
  
  attr_accessor :password_confirmation
  attr_reader :password
  
  def self.authenticate(email, password)
    user = self.find_by_email(email)
    return nil if user && user.hashed_password != encrypted_password(password, user.salt)
    user
  end 
  
  def password=(pwd) 
    @password = pwd 
    return if pwd.blank?  
    self.hashed_password = User.encrypted_password(self.password, create_new_salt) 
  end 
  
  private 
  def self.encrypted_password(password, salt)
    string_to_hash = password + "eshop" + salt
    Digest::SHA1.hexdigest(string_to_hash) 
  end
  
  def create_new_salt
    self.salt = self.object_id.to_s + rand.to_s
  end
  
end
