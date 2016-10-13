class Admin::CategoriesController < ApplicationController
  before_filter :authorize

  def index
    @category = Category.all.order(created_at: :desc)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.create(params.require(:category).permit(:name))
    redirect_to [:admin, :categories]
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/'
  end

end
