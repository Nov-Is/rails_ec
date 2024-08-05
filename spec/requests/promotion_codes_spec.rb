# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'PromotionCodes', type: :request do
  describe 'GET /update' do
    it 'returns http success' do
      get '/promotion_codes/update'
      expect(response).to have_http_status(:success)
    end
  end
end
