module Braspag::Request
    class BraspagError < StandardError
        def initialize(msg=nil)
            super
        end
    end
end
