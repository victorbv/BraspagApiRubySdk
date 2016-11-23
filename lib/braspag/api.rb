require "braspag/environment"
require "braspag/merchant"

require "braspag/api/address"
require "braspag/api/credit_card"
require "braspag/api/customer"
require "braspag/api/payment"
require "braspag/api/recurrent_payment"
require "braspag/api/sale"

require "braspag/api/request/create_sale_request"
require "braspag/api/request/query_sale_request"
require "braspag/api/request/update_sale_request"

module Braspag
    #  The Braspag API SDK front-end
    class API
        attr_accessor :merchant, :environment
        private :merchant, :environment

        # Create an instance of API by choosing the environment where the
        # requests will be send
        #
        # @param merchant [Merchant] The merchant credentials
        # @param environment [Environment] The environment
        def initialize(
            merchant,
            environment = nil)

            if (environment == nil)
                environment = Environment.production()
            end

            @merchant = merchant
            @environment = environment
        end

        # Send the Sale to be created and return the Sale with tid and the status
        # returned by Braspag.
        #
        # @param sale [Sale] The preconfigured Sale
        # @return [Sale] The Sale with authorization, tid, etc. returned by Braspag.
        def create_sale(sale)
            request = Braspag::Request::CreateSaleRequest.new(merchant, environment)

            request.execute(sale)
        end

        # Query a Sale on Braspag by paymentId
        #
        # @param paymentId [String] The paymentId to be queried
        # @return [Sale] The Sale with authorization, tid, etc. returned by Braspag.
        def get_sale(payment_id)
            request = Braspag::Request::QuerySaleRequest.new(merchant, environment)

            request.execute(payment_id)
        end

        # Cancel a Payment on Braspag by paymentId and speficying the amount
        #
        # @param paymentId [String] The paymentId to be queried
        # @param amount [Integer] Order value in cents
        # @return [Payment] The cancelled payment
        def cancel_payment(payment_id, amount=nil)
            request = Braspag::Request::UpdateSaleRequest.new("void", merchant, environment)

            request.amount = amount

            request.execute(payment_id)
        end

        # Capture a Sale on Braspag by paymentId and specifying the amount and the
        # serviceTaxAmount
        #
        # @param paymentId [String] The paymentId to be captured
        # @param amount [Integer] Amount of the authorization to be captured
        # @param serviceTaxAmount [Integer] Amount of the authorization should be destined for the service charge
        # @return [Payment] The captured payment
        def capture_sale(payment_id, amount=nil, service_tax_amount=nil)
            request = Braspag::Request::UpdateSaleRequest.new("capture", merchant, environment)

            request.amount = amount
            request.service_tax_amount = service_tax_amount

            request.execute(payment_id)
        end
    end
end
