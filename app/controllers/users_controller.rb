class UsersController < ApplicationController
  load_and_authorize_resource

  def show
  	@user = User.find(params[:id])
  end

  def index
  	@users = User.all
  end
  def new
  	@user= User.new
  end

  def create
  	@user = User.new(user_params)
  	params[:user].delete(:password) if params[:user][:password].blank?
    params[:user].delete(:password_confirmation) if params[:user][:password].blank? and params[:user][:password_confirmation].blank?

    respond_to do |format|
      if @user.save
        format.html { 
          flash[:notice] = "El Usuario se creó satisfactoriamente." 
          redirect_to users_path
        }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    params[:user].delete(:password) if params[:user][:password].blank?
    params[:user].delete(:password_confirmation) if params[:user][:password].blank? and params[:user][:password_confirmation].blank?
    if @user.update_attributes(user_params)
      flash[:notice] = "El Usuario se actualizó satisfactoriamente." 
      redirect_to users_path
    else
      render :action => 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:notice] = "El Usuario se eliminó satisfactoriamente." 
      redirect_to users_path
    end
  end 

  private

  def user_params
    params.require(:user).permit(:name, :username, :email, :password, :password_confirmation, roles: [] )
  end
end