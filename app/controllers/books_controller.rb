class BooksController < ApplicationController
    before_action :set_book, only: [:show, :edit, :update, :destroy]
   
    def index
        @books = Book.all
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
            #flash[:notice] = 'book is updated successfully.'
            render json: @book
        else
            render json: @book.errors
        end
    end
    
    def destroy
        @book.destroy
        render json: @book
    end

    private

    def set_book
        @book = Book.find(params[:id])
    end

    def book_params
        params.require(:book).permit(:title, :author, :rating)
    end
end