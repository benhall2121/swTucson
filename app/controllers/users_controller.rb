class UsersController < ApplicationController
  require 'rqrcode'
  before_filter :login_required, :except => [:new, :create]

  def new
    if current_user	 
    	redirect_to user_path(current_user)	    
      return
    end	
    @user = User.new
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
    @qr = RQRCode::QRCode.new(request.protocol + request.host_with_port + user_path(current_user))
  end
end
