class User < ActiveRecord::Base
  # new columns need to be added here to be writable through mass assignment
  attr_accessible :username, :email, :password, :password_confirmation, :fname, :lname, :band, :photo, :arts_type, :ind_group, :name, :artist_name, :bio, :web_site, :facebook, :twitter, :youTube 

  attr_accessor :password
  before_save :prepare_password
  
  has_attached_file :photo, :styles => { :icon => "40x40#", :small => "150x150>" }, #:styles      => {:icon => "50x50#", :thumb=> "100x100#", :small  => "190x190#", :large => "500x500>" },
    :url  => "/assets/user/:id/:style/:basename.:extension",
    :path => ":rails_root/public/assets/user/:id/:style/:basename.:extension",
    :default_url => "/assets/user/default/:style/default.jpg"

  validates_attachment_size :photo, :less_than => 5.megabytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png', 'image/pjpeg', 'image/x-png', 'image/jpg']

  validates_presence_of :username
  validates_uniqueness_of :username, :email, :allow_blank => true
  validates_format_of :username, :with => /^[-\w\._@]+$/i, :allow_blank => true, :message => "should only contain letters, numbers, or .-_@"
  validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
  validates_presence_of :password, :on => :create
  validates_confirmation_of :password
  validates_length_of :password, :minimum => 4, :allow_blank => true

  # login can be either username or email address
  def self.authenticate(login, pass)
    user = find_by_username(login) || find_by_email(login)
    return user if user && user.password_hash == user.encrypt_password(pass)
  end

  def encrypt_password(pass)
    BCrypt::Engine.hash_secret(pass, password_salt)
  end

  private

  def prepare_password
    unless password.blank?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = encrypt_password(password)
    end
  end
end
