# frozen_string_literal: true

module API::V1
  class APIController < ActionController::Base
    rescue_from ActionController::RoutingError, with: :render_not_found

    protect_from_forgery with: :null_session, if: proc { |c| c.request.format == 'application/json' }

    def render_not_found
      render json: { error: 'Not Found' }.to_json, status: 404
    end
  end
end
