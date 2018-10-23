# frozen_string_literal: true

module JsonHelpers
  def json(options = {})
    @json ||= JSON.parse(response.body, options)
  end

  def json_response(options = {})
    json(options.merge(symbolize_names: true))
  end

  def api_get(path, *args)
    get "http://api.example.com/v1/#{path}", *args
  end
end
