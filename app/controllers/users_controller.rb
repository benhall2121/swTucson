class UsersController < ApplicationController
  require 'rqrcode'
  before_filter :login_required, :except => [:new, :create, :show, :home, :about_us, :index]

  def index
    @users = User.search(params[:search]).paginate(:per_page => 10, :page => params[:page]) 
  end
  
  def new
    if current_user	 
    	redirect_to user_path(current_user)	    
      return
    end	
    @user = User.new(:user_type => params[:user_type])
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user), :notice => "Thank you for signing up! You are now logged in."
    else
      render :action => 'new'
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      redirect_to(@user, :notice => 'User was successfully updated.') 
    else
      render :action => 'edit'
    end
  end
  
  def show  
    @user = User.find(params[:id])
  end
  
  def home
    @fa_user = User.find(rand(User.count+1))
    @upcoming_events = Event.find(:all, :conditions => ['event_date > ?', Time.now ], :order => 'event_date', :limit => 5)
  end
  
  def about_us  
  end
  
  def qr_code
  end
  
  def donate_paypal
    @user = User.find(params[:id])
    amount = params[:amount].gsub(/\$/,"").to_i
    amount_to_donate_to_iTip = (amount * 0.3)
    amount_to_donate_to_artist = amount - amount_to_donate_to_iTip
  	  
    values = {
      :cmd => '_xclick',
      :business => @user.paypal_email,
      :item_name => "Donating to " + username(@user),
      :currency_code => "USD",
      :amount => amount_to_donate_to_artist,
      :upload => 1,
      :return => user_url(@user)
    }
  	  
    redirect_to "https://www.sandbox.paypal.com/cgi-bin/webscr?" + values.to_query
    
  end
  
  def username(u)
    name = ''	  
    if !u.artist_name.nil? && !u.artist_name.blank?
      name = u.artist_name + ' '
    end
    
    if name == '' && !u.name.nil? && !u.name.blank?
      name = u.name	
    end
    
    if name == '' && !u.username.nil? && !u.username.blank?
      name = u.username    
    end
    
    if name.nil? && name.blank?
      name = ''    
    end 
    
    return name
  end
end
