# frozen_string_literal: true

json.extract! maintenance_item, :id, :item_name, :description, :total_amount, :available_amount, :created_at,
              :updated_at
json.url maintenance_item_url(maintenance_item, format: :json)
