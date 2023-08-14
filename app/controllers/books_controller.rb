class BooksController < ApplicationController
  before_action :is_matching_login_user, only: [:edit]
  before_action :authenticate_user!
  def new
     @book = Book.new
  end
  
  def create
    @book = Book.new(book_params)
    @books = Book.all
    @book.user = current_user
    @user = current_user
    if @book.save
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@book.id)
    else
      render :index
    end
  end
  
  
  
  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
  end
  
  def show
    @books = Book.all
    @book_new = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
  end
  
  def edit
    @books = Book.all
    @book = Book.find(params[:id])
  end
  
  def update
    @books = Book.all
    @book = Book.find(params[:id])
    @book.update(book_params)
    if @book.save
      flash[:notice] = "Book was successfully updated."
      redirect_to book_path(@book.id)  
    else
      render :edit
    end
  end
 
  def destroy
    book = Book.find(params[:id]) 
    book.destroy
    redirect_to books_path
  end
 
  private
  
  def book_params
    params.require(:book).permit(:title, :body)
  end
  
  def is_matching_login_user
    book = Book.find(params[:id])
    user = book.user
    unless user == current_user
      redirect_to books_path
    end
  end
  
end
