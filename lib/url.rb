# frozen_string_literal: true

# Note: $link_storage is a global variable

class Url
  attr_reader :url_original, :short_url

  def initialize(inputed_url)
    @url_original = inputed_url && add_http_if_need(inputed_url.strip).downcase
    @short_url = find_short_url || generate_short_url
    ($link_storage[@short_url] ||= @url_original) if @url_original
  end

  private

  def find_short_url
    result = $link_storage.select { |_key, value| value == @url_original }
    result&.keys&.first
  end

  def generate_short_url
    short_url = ''
    begin
      short_url = [*('a'..'z'), *('0'..'9')].sample(6).join
    end while $link_storage[short_url]
    short_url
  end

  def add_http_if_need(str)
    str =~ /^[http|https].*/ ? str : "http://#{str}"
  end
end
