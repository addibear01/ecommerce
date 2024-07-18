class CategoriesController < ApplicationController

  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
    @teddy_types = @category.teddy_types.page(params[:page])
  end
end
