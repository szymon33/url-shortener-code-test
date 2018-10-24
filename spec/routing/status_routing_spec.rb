# frozen_string_literal: true

require 'rails_helper'

describe 'status route', type: :routing do
  subject { api_get 'status' }

  it { is_expected.to be_routable }
  it {
    is_expected.to route_to(subdomain: 'api',
                            controller: 'api/v1/homes',
                            action: 'status')
  }
end
