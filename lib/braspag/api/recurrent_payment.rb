module Braspag
    class RecurrentPayment
        INTERVAL_MONTHLY = "Monthly"
        INTERVAL_BIMONTHLY = "Bimonthly"
        INTERVAL_QUARTERLY = "Quarterly"
        INTERVAL_SEMIANNUAL = "SemiAnnual"
        INTERVAL_ANNUAL = "Annual"

        attr_accessor :authorize_now,
                      :start_date,
                      :end_date,
                      :interval

        def initialize(authorize_now=true)
            @authorize_now = authorize_now
        end

        def to_json(*options)
            hash = as_json(*options)
            hash.reject! {|k,v| v.nil?}
            hash.to_json(*options)
        end

        def self.from_json(data)
            if (data != nil)
                recurrent_payment = RecurrentPayment.new(data["AuthorizeNow"] || false)

                recurrent_payment.start_date =data["StartDate"] || nil
                recurrent_payment.end_date =data["EndDate"] || nil
                recurrent_payment.interval =data["Interval"] || nil

                return recurrent_payment
            end
        end

        # private
        def as_json(options={})
            {
                AuthorizeNow: @authorize_now,
                StartDate: @start_date,
                EndDate: @end_date,
                Interval: @interval
          }
        end
    end
end
