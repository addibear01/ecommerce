# frozen_string_literal: true

# Helper methods for rendering order details
def render_order_details(order)
  attributes_table_for order do
    row :id
    row :user
    row :created_at
    row :updated_at
    row :total_amount, &:formatted_total_amount
    row :payment_status
    row :order_status
    row :payment_id
  end
end

def render_order_items(order)
  panel 'Order Items' do
    table_for order.order_items do
      column :teddy_type
      column :quantity
      column :price
    end
  end
end

def render_order_taxes(order)
  panel 'Taxes' do
    table_for order.calculate_taxes.to_a do
      column :tax_name, &:upcase
      column :tax_amount, &:formatted_amount
    end
  end
end

# Permitted parameters for Order
def permitted_order_params
  %i[
    user_id street city province postal_code total_amount payment_status
    order_status payment_id
  ]
end

# Action items for Order
def order_action_items
  action_item :ship_order, only: :show do
    link_to 'Mark as Shipped', mark_as_shipped_admin_order_path(order), method: :put if order.paid?
  end
end

# Member actions for Order
def order_member_actions
  member_action :mark_as_shipped, method: :put do
    resource.update(order_status: :shipped)
    redirect_to resource_path, notice: 'Order marked as shipped.'
  end
end
ActiveAdmin.register Order do
  permit_params :user_id, :street, :city, :province, :postal_code, :total_amount, :payment_status, :order_status, :payment_id

  controller do
    def find_resource
      Order.includes(:order_items).find(params[:id])
    end
  end

  filter :user
  filter :created_at
  filter :updated_at
  filter :total_amount
  filter :street
  filter :city
  filter :province
  filter :postal_code
  filter :payment_status
  filter :payment_id
  filter :order_status

  index do
    selectable_column
    id_column
    column :user
    column :created_at
    column :total_amount do |order|
      number_to_currency(order.total_amount)
    end
    column :payment_status
    column :order_status
    column :payment_id
    actions
  end

  show do
    attributes_table do
      row :id
      row :user
      row :created_at
      row :updated_at
      row :total_amount do
        number_to_currency(order.total_amount)
      end
      row :payment_status
      row :order_status
      row :payment_id
    end

    panel "Order Items" do
      table_for order.order_items do
        column :teddy_type
        column :quantity
        column :price
      end
    end

    panel "Taxes" do
      table_for order.calculate_taxes.to_a do
        column :tax_name do |tax|
          tax[0].to_s.upcase
        end
        column :tax_amount do |tax|
          number_to_currency(tax[1])
        end
      end
    end

    active_admin_comments
  end

  form do |f|
    f.inputs do
      f.input :user
      f.input :street
      f.input :city
      f.input :province
      f.input :postal_code
      f.input :total_amount
      f.input :payment_status
      f.input :order_status, as: :select, collection: Order.order_statuses.keys
      f.input :payment_id
    end
    f.actions
  end

  action_item :ship_order, only: :show do
    link_to 'Mark as Shipped', mark_as_shipped_admin_order_path(order), method: :put if order.paid?
  end

  member_action :mark_as_shipped, method: :put do
    resource.update(order_status: :shipped)
    redirect_to resource_path, notice: "Order marked as shipped."
  end
end
