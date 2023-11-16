Welcome! You have signed up successfully.
Signed out successfully.






class BooksController < ApplicationController
  def new
      @book = Book.new
  end

  def index
      @books = Book.all
      @book = Book.new
  end

  def show
      @book = Book.find(params[:id])
  end

  def edit
      @book = Book.find(params[:id])
  end

  def create
      @book = Book.new(book_params)
    if @book.save
       flash[:notice] = "successfully"
       redirect_to book_path(@book.id)
    else flash[:notice] ="error"
      @books = Book.all
      render:index
    end
  end

  def update
      @book = Book.find(params[:id])
    if @book.update(book_params)
       flash[:notice] ="successfully"
       redirect_to book_path(@book.id)
    else flash[:notice] ="error"
      @books = Book.all
      render:edit
    end
  end

  def destroy
      book = Book.find(params[:id])
    if book.destroy
       redirect_to '/books'
       flash[:notice] ="successfully"
    else flash[:notice] ="error"
      @books = Book.all
       render:index
    end
  end

private

  def book_params
    params.require(:book).permit(:title,:body)
  end
end





book
class BooksController < ApplicationController

  def create
      @user = current_user
      @book = Book.new(book_params)
    if @book.save
       flash[:notice] = "successfully"
       redirect_to book_path(@book.id)
    else flash[:notice] ="error"
       @books = Book.all
      render:index
    end
  end

  def index
    @books = Book.all
    @user = current_user
  end


  def show
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
      @book = Book.find(params[:id])
    if @book.update(book_params)
       flash[:notice] ="successfully"
       redirect_to book_path(@book.id)
    else flash[:notice] ="error"
      @books = Book.all
      render:edit
    end
  end

  def destroy
      book = Book.find(params[:id])
    if book.destroy
       redirect_to '/books'
       flash[:notice] ="successfully"
    else flash[:notice] ="error"
      @books = Book.all
       render:index
    end
  end

private

  def book_params
    params.require(:book).permit(:title,:body)
  end
end

user contoroller
class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]

  def new
  end

  def show
  end

  def edit
    @user = User.find(params[:id])
  end

  def index
    @user=current_user
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end

  def user_params
    params.require(:user).permit(:name, :profile_image)
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to post_images_path
    end
  end
end

user model
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable
  has_many :books, dependent: :destroy
  has_one_attached :image
  validates :name, uniqueness: true
  def get_profile_image(width, height)
  unless image.attached?
    file_path = Rails.root.join('app/assets/images/no_image.jpg')
    image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
  end
    image.variant(resize_to_limit: [width, height]).processed
  end

end
