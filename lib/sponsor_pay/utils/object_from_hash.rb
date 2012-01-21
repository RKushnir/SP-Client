require 'delegate'

module SponsorPay
	module Utils
    class ObjectFromHash < DelegateClass(Hash)
      def initialize(hash)
        super(symbolize_hash_keys(hash))

        keys.each do |key|
          instance_eval <<-EOF
            def #{key}
              @#{key} ||= case self[:#{key}]
              when Hash then ObjectFromHash.new(self[:#{key}])
              else self[:#{key}]
              end
            end
          EOF
        end
      end

      private

      def symbolize_hash_keys(hash)
        hash.keys.inject({}) do |symbolized, key|
          symbolized[(key.to_sym rescue key) || key] = hash[key]
          symbolized
        end
      end
    end
	end
end
