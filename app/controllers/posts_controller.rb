class PostsController < ApplicationController
  before_action :set_post, only: %i(show edit update destroy)
  PER_PAGE = 10

  def create
    post = Post.new(post_params)
    if post.text.present?
      post.save
      flash[:notice] = "投稿が保存されました"
    else
      flash[:alert] = "投稿に失敗しました"
    end
    redirect_to root_path
  end

  def index
    @post = Post.new
    @post.photos.build
    @posts = Post.includes(:photos, :user).order("created_at DESC").page(params[:page]).per(PER_PAGE)
  end

  def edit
  end

  def update
    if @post.update_attributes(post_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    if @post.user == current_user
      flash[:notice] = "投稿が削除されました" if @post.destroy
    else
      flash[:alert] = "投稿の削除に失敗しました"
    end
    redirect_to root_path
  end

  private

  def post_params
    params.require(:post).permit(:text, photos_attributes: [:image]).merge(user_id: current_user.id)
  end

  def set_post
    @post = Post.find_by(id: params[:id])
  end
end
