require 'delegate'

module SponsorPay
  class Response < DelegateClass(Net::HTTPResponse)
    extend Forwardable
    def_delegators :@data, :code, :message, :count, :pages, :information, :offers

    def initialize(response)
      super
      @data = Utils::ObjectFromHash.new(JSON.parse(body))
    end
  end
end
