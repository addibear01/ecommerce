class TeddyTypesController < ApplicationController
  def index
    @categories = Category.all
    @teddy_types = TeddyType.all

    if params[:search].present? && params[:category_id].present?
      @category = Category.find(params[:category_id])
      @teddy_types = @category.teddy_types.where("LOWER(teddy_name) LIKE ? OR LOWER(description) LIKE ?", "%#{params[:search].downcase}%", "%#{params[:search].downcase}%")
    elsif params[:search].present?
      @teddy_types = TeddyType.where("LOWER(teddy_name) LIKE ? OR LOWER(description) LIKE ?", "%#{params[:search].downcase}%", "%#{params[:search].downcase}%")
    elsif params[:category_id].present?
      @category = Category.find(params[:category_id])
      @teddy_types = @category.teddy_types
    end

    case params[:filter]
    when 'on_sale'
      @teddy_types = @teddy_types.on_sale
    when 'new'
      @teddy_types = @teddy_types.new_products
    when 'recently_updated'
      @teddy_types = @teddy_types.recently_updated
    end

    @teddy_types = @teddy_types.page(params[:page]).per(3)
  end

  def show
    @teddy_type = TeddyType.find(params[:id])
  end
end
