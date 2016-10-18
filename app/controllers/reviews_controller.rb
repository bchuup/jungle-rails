class ReviewsController < ApplicationController

  def create
    @product = Product.find params[:product_id]
    @review = @product.reviews.new(review_params)
    if @review.save
      redirect_to :back, notice: 'Review posted!'
    else
      render :back, notice: 'Review was not posted! Try again'
    end
  end

  def destroy
    @review = Review.find params[:id]
    puts params
    @review.destroy
    redirect_to :back, notice: 'Review deleted!'
  end

  private
    def review_params
      new_params = params.require(:review).permit(
        :rating,
        :description
      )

      new_params[:user_id] = current_user.id
      return new_params
    end
end

