# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MaintenanceItemsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/maintenance_items').to route_to('maintenance_items#index')
    end

    it 'routes to #new' do
      expect(get: '/maintenance_items/new').to route_to('maintenance_items#new')
    end

    it 'routes to #show' do
      expect(get: '/maintenance_items/1').to route_to('maintenance_items#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/maintenance_items/1/edit').to route_to('maintenance_items#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/maintenance_items').to route_to('maintenance_items#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/maintenance_items/1').to route_to('maintenance_items#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/maintenance_items/1').to route_to('maintenance_items#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/maintenance_items/1').to route_to('maintenance_items#destroy', id: '1')
    end
  end
end
