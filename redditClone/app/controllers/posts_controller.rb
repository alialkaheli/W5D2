class PostsController < ApplicationController

  before_action :required_logged_in, except: [:show]
  before_action :require_user_owns_post!, only: [:edit, :update]

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def post_params
    params.require(:post).permit(:url, :title, :content)
  end

  def require_user_owns_post!
    return if current_user.posts.find_by(id: params[:id])
    render json: 'error', status: :forbidden
  end


end
