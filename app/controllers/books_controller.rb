class BooksController < ApplicationController
    before_action :set_book, only: [:show, :edit, :update, :destroy]
   
    def index
        @books = Book.where(nil)
        @books = Book.filter_by_starts_with(params[:starts_with]) if params[:starts_with].present?
        render json: @books
    end

    def new
        @book = Book.new
    end

    def create
        if @current_user.admin
            @book = Book.new(book_params)
            #@book.user_id=@current_user.id
        #@book.user = current_user
            if @book.save
                render json: @book
            else
                render json: @book.errors
            end
        else
            render json: {error: "You're not authorized"}
        end
    end
    
    def edit
        render json: @book
    end

    def show
        render json: @book
    end

    def update
        if @book.update(book_params)

            render json: @book
        else
            render json: @book.errors
        end
    end
    
    def destroy
        if @current_user.admin?
            @id=@book.id
            Comment.where(post_id: Post.where(category_id: Category.find_by(category_name: "books").id).where(item_id: @id)).delete_all
            Post.where(category_id: Category.find_by(category_name: "books").id).where(item_id: @id).delete_all

            @book.destroy
            render json: @book
        else
            render json: "You're not an admin"
        end
    end

    private

    def set_book
        @book = Book.find(params[:id])
    end

    def book_params
        params.require(:book).permit(:title, :author, :rating)
    end
end
