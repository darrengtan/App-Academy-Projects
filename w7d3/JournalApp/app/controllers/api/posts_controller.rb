class Api::PostsController < ApplicationController
  def index
    @posts = Post.all
    render :json => @posts
  end

  def show
    @post = Post.find(params[:id])
    render :json => @post
  end

  # def new
  #   @post = Post.new
  #   render "new"
  # end

  def create
    @post = Post.new(post_params)
    if @post.save
      render :json => @post
    else
      render :json => @post.errors, status: :unprocessable_entity
    end
  end

  # def edit
  #   @post = Post.find(params[:id])
  #   render "edit"
  # end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      render :json => @post
    else
      render :json => @post.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy!
    render json: @post
  end

  private
  def post_params
    params.require(:post).permit(:title, :body)
  end
end
