require 'net/http'

module SponsorPay
  class Request
    REQUIRED_PARAMETERS = [:format, :application_id, :user_id, :locale, :device_id]

    def initialize(params)
      @parameters = params.reverse_merge default_parameters
      validate!
    end

    def response
      @response ||= Response.new(Net::HTTP.get_response(uri), parameters(:format))
    end

    private

    def default_parameters
      {
        format: SponsorPay.format,
        application_id: SponsorPay.application_id,
        locale: SponsorPay.locale
      }
    end

    def validate!
      REQUIRED_PARAMETERS.each do |param_name|
        raise ArgumentError, "#{param_name.to_s.camelize} not specified" if parameters(param_name).nil?
      end
    end

    def uri
      URI::HTTP.build(:host => host, :path => path, :query => query.to_s)
    end

    def host
      SponsorPay.host
    end

    def path
      [SponsorPay.path, parameters(:format)].join '.'
    end

    def query
      Query.new(query_parameters)
    end

    def query_parameters
      params = {
        appid: parameters(:application_id),
        uid: parameters(:user_id),
        ip: parameters(:ip),
        locale: parameters(:locale),
        page: parameters(:page),
        device_id: parameters(:device_id),
        ps_time: parameters(:registered_at) && parameters(:registered_at).to_i,
        offer_types: parameters(:offer_types),
        android_id: parameters(:android_id),
      }

      params.delete_if {|k,v| v.nil? }.merge!(query_custom_parameters)
    end

    def query_custom_parameters
      Array(parameters :custom).each_with_index.inject({}) { |hash, (param, index)|
        hash.merge Hash[:"pub#{index}", param]
      }
    end

    def parameters(key)
      @parameters[key]
    end
  end
end
