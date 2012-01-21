module SponsorPay
  module Utils
    class JsonParser
      def self.parse(response_body)
        JSON.parse(response_body)
      end
    end
  end
end
