# frozen_string_literal: true

require 'rails_helper'

describe API::V1::HomesController do
  let(:short_url) { 'eNrLKCkpsNLXLy8v10vPz0_PSdVLzs8FAFWyB9Y=' }

  describe 'POST root route' do
    describe 'when valid' do
      before { post :create, url: 'www.google.com' }

      it 'is created' do
        expect(response.status).to eql 201 # created
      end

      context 'json response' do
        subject { json_response }

        it { is_expected.to include(url: 'http://www.google.com') }
        it { is_expected.to include(short_url: short_url) }
      end
    end

    describe 'when invalid' do
      before { post 'create', {} }

      it 'is unprocessable entity' do
        expect(response.status).to eql 422 # Unprocessable Entity
      end

      context 'json response' do
        subject { json_response }

        it { is_expected.to include(error: 'Unprocessable Entity') }
      end
    end
  end

  describe 'GET show' do
    describe 'when valid' do
      before do
        allow($link_storage).to receive(:[])
          .with(short_url).and_return('http://www.google.com')
        get :show, short_url: short_url
      end

      it 'is moved permanently' do
        expect(response.code).to eql '301'
      end

      it 'is redirects back to encoded page' do
        expect(response).to redirect_to 'http://www.google.com'
      end
    end

    describe 'when invalid' do
      before { get :show, short_url: 'LaLaLand' }

      it 'is success' do
        expect(response.status).to eql 404 # not found
      end

      context 'json response' do
        subject { json_response }

        it { is_expected.to include(error: 'Not Found') }
      end
    end
  end

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
