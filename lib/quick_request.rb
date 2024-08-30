# frozen_string_literal: true

require 'net/http'
require 'uri'

require_relative "quick_request/version"

module QuickRequest
  class Error < StandardError; end
  class Builder
    def initialize(method: :get, url: nil, use_ssl: false)
      @method = method
      @url = URI.parse(url) unless url.nil?
      @query_params = {}
      @body = nil
      @headers = {}
      @use_ssl = use_ssl
    end

    def query_params(params)
      @query_params = params
      self
    end

    def body(content)
      @body = content.is_a?(Hash) ? URI.encode_www_form(content) : content
      self
    end

    def headers(headers)
      @headers = headers
      self
    end

    def send
      apply_query_params
      http = Net::HTTP.new(@url.host, @url.port)
      http.use_ssl = @use_ssl

      request = create_http_request
      add_headers_to_request(request)
      request.body = @body if @body

      response = http.request(request)
      response.body
    end

    private

    def apply_query_params
      if @query_params.any?
        query = URI.encode_www_form(@query_params)
        @url.query = [@url.query, query].compact.join('&')
      end
    end

    def create_http_request
      case @method
      when :get
        Net::HTTP::Get.new(@url)
      when :post
        Net::HTTP::Post.new(@url)
      when :put
        Net::HTTP::Put.new(@url)
      when :delete
        Net::HTTP::Delete.new(@url)
      else
        raise "Unsupported HTTP method: #{@method}"
      end
    end

    def add_headers_to_request(request)
      @headers.each do |key, value|
        request[key] = value
      end
    end
  end
end
