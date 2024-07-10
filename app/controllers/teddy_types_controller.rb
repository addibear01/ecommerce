class TeddyTypesController < ApplicationController
  def index
    @teddy_types = TeddyType.all
  end

  def show
    @teddy_type = TeddyType.find(params[:id])
  end
end
