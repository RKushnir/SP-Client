require 'digest/sha1'

module SponsorPay
  class Response
    extend Forwardable
    def_delegators :@data, :code, :message, :count, :pages, :information, :offers

    def initialize(response, format)
      @response = response
      @format = format
      @data = Utils::ObjectFromHash.new(parser.parse(@response.body))
      validate!
    end

    def successful?
      code == "OK"
    end

    private

    def parser
      Utils.const_get("#{@format.to_s.camelize}Parser")
    rescue NameError
      raise UnsupportedFormatError
    end

    def validate!
      return if hash_key == @response['x-sponsorpay-response-signature']
      raise SecurityError, "Invalid response signature"
    end

    def hash_key
      Digest::SHA1.hexdigest([@response.body, SponsorPay.api_key].join)
    end
  end
end
