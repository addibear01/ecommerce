class CategoriesController < ApplicationController
  before_action :set_category, only: [:show]

  add_breadcrumb "Categories", :categories_path, only: [:index]

  def index
    @categories = Category.all
  end

  def show
    add_breadcrumb @category.category_name, category_path(@category)
    @teddy_types = @category.teddy_types.page(params[:page]).per(5)
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end
end
