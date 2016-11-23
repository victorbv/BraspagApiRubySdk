module Braspag
    # API Environment URLs
    #
    # @attr [String] api API URL
    # @attr [String] apiQuery API Query URL
    class Environment
        attr_accessor :api,
                      :api_query

        def initialize(api, api_query)
            @api = api
            @api_query = api_query
        end

        # The production environment
        #
        # @return [Environment] a configured Environment for production
        def self.production()
            return Environment.new("https://api.braspag.com.br/",
                                   "https://apiquery.braspag.com.br/")
        end

        # The sandbox environment
        #
        # @return [Environment] a configured Environment for testing
        def self.sandbox()
            return Environment.new("https://apisandbox.braspag.com.br/",
                                   "https://apiquerysandbox.braspag.com.br/")
        end
    end
end
