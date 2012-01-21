require 'digest/sha1'

module SponsorPay
  class Query
    def initialize(params)
      @parameters = params.reverse_merge(:timestamp => timestamp)
    end

    def to_s
      URI.encode(signed)
    end

    private

    def unsigned
      pairs = @parameters.keys.sort.map {|key| "#{key}=#{@parameters[key]}" }
      pairs.join '&'
    end

    def signed
      [unsigned, "hashkey=#{hash_key}"].join '&'
    end

    def timestamp
      Time.now.to_i
    end

    def hash_key
      Digest::SHA1.hexdigest([unsigned, SponsorPay.api_key].join '&')
    end
  end
end
