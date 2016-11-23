require "braspag/api/request/braspag_request"

module Braspag::Request
    class QuerySaleRequest < BraspagRequest
        attr_accessor :environment
        private :environment

        def initialize(merchant, environment)
            super(merchant)

            @environment = environment
        end

        def execute(payment_id)
            uri = URI.parse(@environment.api_query + "v2/sales/" + payment_id)

            Braspag::Sale.from_json(send_request("GET", uri))
        end
    end
end
