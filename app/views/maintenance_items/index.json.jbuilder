# frozen_string_literal: true

json.array! @maintenance_items, partial: 'maintenance_items/maintenance_item', as: :maintenance_item
