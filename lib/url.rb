# frozen_string_literal: true

require 'zlib'
require 'base64'
include Zlib

# Note: $link_storage is a global variable

class Url
  attr_reader :url_original

  def initialize(inputed_url)
    @url_original = inputed_url && add_http_if_need(inputed_url.strip).downcase
    ($link_storage[encoded_data] ||= @url_original) if @url_original
  end

  def compressed_data
    Deflate.deflate(@url_original, BEST_COMPRESSION)
  end

  def encoded_data
    Base64.urlsafe_encode64(compressed_data)
  end

  private

  def add_http_if_need(str)
    str =~ /^[http|https].*/ ? str : "http://#{str}"
  end
end
