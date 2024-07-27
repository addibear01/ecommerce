# frozen_string_literal: true

# This migration comes from active_storage (originally 20170806125915)
class CreateActiveStorageTables < ActiveRecord::Migration[7.0]
  def change
    create_active_storage_blobs
    create_active_storage_attachments
    create_active_storage_variant_records
  end

  private

  def create_active_storage_blobs
    create_table :active_storage_blobs, id: primary_key_type do |table|
      add_blob_columns(table)
      add_blob_indexes(table)
    end
  end

  def add_blob_columns(table)
    table.string :key, null: false
    table.string :filename, null: false
    table.string :content_type
    table.text :metadata
    table.string :service_name, null: false
    table.bigint :byte_size, null: false
    table.string :checksum

    add_blob_timestamps(table)
  end

  def add_blob_timestamps(table)
    if connection.supports_datetime_with_precision?
      table.datetime :created_at, precision: 6, null: false
    else
      table.datetime :created_at, null: false
    end
  end

  def add_blob_indexes(table)
    table.index [:key], unique: true
  end

  def create_active_storage_attachments
    create_table :active_storage_attachments, id: primary_key_type do |table|
      add_attachment_columns(table)
      add_attachment_indexes(table)
    end
  end

  def add_attachment_columns(table)
    table.string :name, null: false
    table.references :record, null: false, polymorphic: true, index: false, type: foreign_key_type
    table.references :blob, null: false, type: foreign_key_type

    add_attachment_timestamps(table)
  end

  def add_attachment_timestamps(table)
    if connection.supports_datetime_with_precision?
      table.datetime :created_at, precision: 6, null: false
    else
      table.datetime :created_at, null: false
    end
  end

  def add_attachment_indexes(table)
    table.index %i[record_type record_id name blob_id], name: :index_active_storage_attachments_uniqueness, unique: true
    table.foreign_key :active_storage_blobs, column: :blob_id
  end

  def create_active_storage_variant_records
    create_table :active_storage_variant_records, id: primary_key_type do |table|
      table.belongs_to :blob, null: false, index: false, type: foreign_key_type
      table.string :variation_digest, null: false

      table.index %i[blob_id variation_digest], name: :index_active_storage_variant_records_uniqueness, unique: true
      table.foreign_key :active_storage_blobs, column: :blob_id
    end
  end

  def primary_and_foreign_key_types
    config = Rails.configuration.generators
    setting = config.options[config.orm][:primary_key_type]
    primary_key_type = setting || :primary_key
    foreign_key_type = setting || :bigint
    [primary_key_type, foreign_key_type]
  end
end
