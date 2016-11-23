require "braspag/api/request/braspag_request"

module Braspag::Request
    class CreateSaleRequest < BraspagRequest
        attr_accessor :environment
        private :environment

        def initialize(merchant, environment)
            super(merchant)

            @environment = environment
        end

        def execute(sale)
            uri = URI.parse(@environment.api + "v2/sales")

            Braspag::Sale.from_json(send_request("POST", uri, sale))
        end
    end
end
