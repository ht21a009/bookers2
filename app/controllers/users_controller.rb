class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit]
  
  
  def index
    @users = User.all
    @user = current_user
    @book = Book.new
  end
  
  def show
    @users = User.all
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
  end
  
  def edit
    @users = User.all
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    if @user.save
      flash[:notice] = "Book was successfully updated."
      redirect_to user_path(@user.id)  
    else
      render :edit
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
  
  def is_matching_login_user
    user = User.find(params[:id])
    unless user == current_user
      redirect_to user_path(current_user.id)
    end
  end
  
end
