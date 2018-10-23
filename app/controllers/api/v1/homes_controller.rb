# frozen_string_literal: true

module API::V1
  class HomesController < APIController
    def status
      render json: { status: 'ok' }, status: 200
    end
  end
end
