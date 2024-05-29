class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!
  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to users_path, notice: 'User successfully updated.'
    else
      render :edit
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.skip_password_validation = true  # Tell the model to skip password validation

    if @user.save
      # Send an invitation email here for the user to set their password
      redirect_to admin_users_path, notice: 'User created successfully. An invitation has been sent.'
    else
      render :new
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path, notice: 'User deleted.'
  end

  private

  def user_params
    params.require(:user).permit(:email, :admin)
  end

  def authorize_admin
    redirect_to root_path, alert: 'Not authorized' unless current_user.admin?
  end
end
