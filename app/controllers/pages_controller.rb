class PagesController < ApplicationController

  def index
    @pages = Page.all
  end

  def new
    @page = Page.new
  end

  def create
    if @page = Page.create(params[:page], without_protection: true)
      return redirect_to @page
    end
    render :new
  end

  def edit
    @page = Page.find(params[:id])
  end

  def update
    @page = Page.find(params[:id])
    if @page.update_attributes(params[:page], without_protection: true)
      return redirect_to @page.path, flash: {success: "Page updated."}
    end
    render :edit
  end

  def destroy
    @page = Page.find(params[:id])
    @page.destroy
    redirect_to :pages, flash: {success: "The page has been deleted."}
  end

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
    if permalink.blank?
      @page = Page.find(params[:id])
    else
      @page = Page.where(permalink: permalink).first
    end

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
