class TeddyTypesController < ApplicationController
  def index
    @categories = Category.all

    if params[:search].present? && params[:category_id].present?
      @category = Category.find(params[:category_id])
      @teddy_types = @category.teddy_types.where("LOWER(teddy_name) LIKE ? OR LOWER(description) LIKE ?", "%#{params[:search].downcase}%", "%#{params[:search].downcase}%").page(params[:page]).per(5)
    elsif params[:search].present?
      @teddy_types = TeddyType.where("LOWER(teddy_name) LIKE ? OR LOWER(description) LIKE ?", "%#{params[:search].downcase}%", "%#{params[:search].downcase}%").page(params[:page]).per(5)
    elsif params[:category_id].present?
      @category = Category.find(params[:category_id])
      @teddy_types = @category.teddy_types.page(params[:page]).per(5)
    else
      @teddy_types = TeddyType.page(params[:page]).per(5)
    end
  end

  def show
    @teddy_type = TeddyType.find(params[:id])
  end
end
