require 'rails_helper'

describe API::V1::HomesController do
  describe 'GET status' do
    before { get :status }

    it 'is success' do
      expect(response.status).to eql 200 # success
    end

    it 'is JSON respnose content type' do
      expect(response.content_type).to eql 'application/json'
    end

    it 'has status OK' do
      expect(json_response).to eq(status: 'ok')
    end
  end
end
