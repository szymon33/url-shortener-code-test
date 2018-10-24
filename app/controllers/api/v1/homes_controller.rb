# frozen_string_literal: true

require 'url'

module API::V1
  class HomesController < APIController
    def create
      if long_url.present?
        url = Url.new(long_url.strip)
        render json: {
          short_url: url.encoded_data,
          url: url.url_original
        }, status: 201
      else
        render json: { error: 'Unprocessable Entity' }, status: 422
      end
    end

    def show
      if short_url && $link_storage[short_url]
        redirect_to $link_storage[short_url]
      else
        render_not_found
      end
    end

    def status
      render json: { status: 'ok' }, status: 200
    end

    private

    def short_url
      @short_url ||= params[:short_url]
    end

    def long_url
      @long_url ||= params['url']
    end
  end
end
