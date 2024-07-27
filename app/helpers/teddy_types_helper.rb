# frozen_string_literal: true

# TeddyTypesHelper provides helper methods for teddy type views.
module TeddyTypesHelper
  def image_variant(teddy_type, size = :small)
    return unless teddy_type.image.attached?

    image_tag teddy_type.image.variant(resize_to_fill: [size == :large ? 300 : 100,
                                                        size == :large ? 300 : 100]).processed
  end
end
