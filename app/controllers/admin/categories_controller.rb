class Admin::CategoriesController < ApplicationController

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

end
