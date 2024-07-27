# frozen_string_literal: true

# TeddyTypesController manages the display and filtering of teddy types.
class TeddyTypesController < ApplicationController
  before_action :set_teddy_type, only: [:show]

  add_breadcrumb "Teddy Types", :teddy_types_path, only: [:index]

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
    add_breadcrumb @teddy_type.category.category_name, category_path(@teddy_type.category)
    add_breadcrumb @teddy_type.teddy_name, teddy_type_path(@teddy_type)
  end

  private

  def set_teddy_type
    @teddy_type = TeddyType.find(params[:id])
  end
end
