module ActiveMerchant
  module Billing
    module AdaptivePaymentResponses
      
      class AdaptivePaypalSuccessResponse
        
        REDIRECT_URL = 'https://www.paypal.com/webscr?cmd=_ap-payment&paykey='
        TEST_REDIRECT_URL = 'https://www.sandbox.paypal.com/cgi-bin/webscr?cmd=_ap-payment&paykey='
        
        attr_reader :paykey
        
        def initialize json
          
          @paykey = json['payKey']
          @params = json
        end
        
        def redirect_url_for
          Base.gateway_mode == :test ? (TEST_REDIRECT_URL + @paykey) : (REDIRECT_URL + @paykey)
        end
        
        def ack
          @params['responseEnvelope']['ack']
        end
        
        def address
          
        end        
        
        def method_missing name
          begin
            @params[name.to_s]
          rescue
            raise AttributenotFound
          end
        end
                  
        def [](key)
          return @params[key] if @params.include? key
          raise AttributenotFound
        end

        def status
          @params['status']
        end

      end
      
      class AdaptivePaypalErrorResponse
        
        def initialize error
          @raw = error
        end
            
        def debug
          @raw.inspect
        end
        
      end
      
    end
  end
end