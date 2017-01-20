class PagesController < ApplicationController
  def index
  end

  def home
    @posts = Post.all
    @newPost = Post.new
  end

  def profile

    if (User.find_by_username(params[:id]))
      @username = params[:id]
    else
      redirect_to root_path, :danger=> 'User not found!'
    end

    @posts = Post.all.where('user_id = ?', User.find_by_username(params[:id]))
    @newPost = Post.new
  end
end
