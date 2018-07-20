class ReviewsController < ApplicationController

  def create

    puts params

    @product = Product.find params[:product_id]
    @review = @product.reviews.create(review_params)
    @review.user = current_user

    if @review.save
      redirect_to product_path(@product), notice: 'Review submitted!'
    else
      render 'products/show'
    end

  end

  private

  def review_params
    params.require(:review).permit(
      :description,
      :rating
    )
  end

end
