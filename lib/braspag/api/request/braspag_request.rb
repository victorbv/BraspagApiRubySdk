require "uuidtools"
require "json"
require "net/http"

require "braspag/api/request/braspag_error"

module Braspag::Request
    class BraspagRequest
        attr_accessor :merchant
        private :merchant

        def initialize(merchant)
            @merchant = merchant
        end

        protected
        def send_request(method, uri, data=nil)
            body = nil
            headers = {"RequestId" => UUIDTools::UUID.random_create.to_s,
                       "MerchantId" => merchant.merchant_id,
                       "MerchantKey" => merchant.merchant_key}

            if (data == nil)
                headers["Content-Length"] = "0"
            else
                headers["Content-Type"] = "application/json"
                body = data.to_json
            end

            client = Net::HTTP.new(uri.host, uri.port)
            client.use_ssl = true

            response = client.send_request(method, uri.path, body, headers)

            data = JSON.parse(response.body)

            raise BraspagError, "Error [" + data[0]["Code"].to_s + "] " + data[0]["Message"] if response.code.to_i >= 400

            return data
        end
    end
end
