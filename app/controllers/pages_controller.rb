class PagesController < ApplicationController

  def home
    @posts = Post.all
  end

  def about
  end

  def faq
  end

  def rules
  end

  def show
    permalink = params[:permalink]
    @page = Page.where(permalink: permalink).first
    if @page.present?
      render :show
    else
      render '404', status: :not_found
    end
  end

  private
    def to_html
    end

end
