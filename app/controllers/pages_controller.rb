# frozen_string_literal: true

# PagesController manages the display of static pages.
class PagesController < ApplicationController
  def show
    @page = Page.find_by!(slug: params[:id].downcase)
  end
end
