require 'digest/sha1'

module SponsorPay
  class Response
    extend Forwardable
    def_delegators :@data, :code, :message, :count, :pages, :information, :offers

    def initialize(response)
      @response = response
      @data = Utils::ObjectFromHash.new(JSON.parse(@response.body))
      validate!
    end

    private

    def validate!
      return if hash_key == @response['x-sponsorpay-response-signature']
      raise SecurityError, "Invalid response signature"
    end

    def hash_key
      Digest::SHA1.hexdigest([@response.body, SponsorPay.api_key].join)
    end
  end
end
