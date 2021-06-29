class PostsController < ApplicationController

    before_action :set_post, only: [:show, :edit, :update, :destroy]

    def index
        @posts = Post.all
        render json: @posts
    end

    def new
        @post = Post.new
    end

    def create
        @post = Post.new(post_params)
        @post.user_id = @current_user.id
        if params[:category_name]=="movies"
            @post.commentable=Movie.find_by(id: params[:item_id])
        else
            @post.commentable=Book.find_by(id: params[:item_id])
        end
        if @post.save  && @post.commentable_id
            render json: @post, status: :created, location:@post
        else
            render json:{errors: @post.errors,message:"Check the api request properly"}, status: :unprocessable_entity
        end
    end

    def custom_show
        @posts = Post.where(category_id: Category.find_by(category_name: params[:category_name]).id)
                    .where(item_id: params[:item_id])
                    .where(user_id: params[:user_id])
                    
        if params[:category_name]=='movies'
            @item = Movie.find_by(id: params[:item_id])
        else
            @item = Book.find_by(id: params[:item_id])
        end
        render json: {Category: @item, posts: @posts.as_json, user: @current_user.as_json(only: [:username,:email])}
    end

    def show
        render json: @post
    end

    def edit
        if @current_user.id==@post.user_id
            render json: @post
        else
            render json: "You can't do that!!"
        end
    end
    
   
    def update
        if @current_user.id == @post.user_id
            if @post.update(post_params)
                render json: @post
            else
                render json: @post.errors
            end
        else
            render json: "You can't do that!!"
        end
    end
    
    def destroy
        if @current_user.id == @post.user_id
            @post.destroy
            render json: @post
        else
            render json: "You can't do that!!"
        end
    end

    private

    def set_post
        @post = Post.find(params[:id])
    end

    def post_params
        params.require(:post).permit(:review)
    end

end
