# frozen_string_literal: true

# ApplicationHelper provides helper methods for views.
module ApplicationHelper
  def provinces
    [
      'Alberta', 'British Columbia', 'Manitoba', 'New Brunswick', 'Newfoundland and Labrador',
      'Nova Scotia', 'Ontario', 'Prince Edward Island', 'Quebec', 'Saskatchewan',
      'Northwest Territories', 'Nunavut', 'Yukon'
    ]
  end
end
