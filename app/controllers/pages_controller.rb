class PagesController < ApplicationController

  def home
    @posts = Post.all
  end

  def about
  end

  def faq
  end

end
