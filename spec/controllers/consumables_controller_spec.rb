# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ConsumablesController, type: :controller do
  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful # be_successful expects a HTTP Status code of 200
    end
  end

  # Add more tests for other actions: show, create, update, delete
end
