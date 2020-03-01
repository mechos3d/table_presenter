if Rails.const_defined?('Console')
  module OpTools
    module DrawTable
      module Presenter
        module Order
          class LoyaltyParameters
            def call(order)
              {
                inn: order.inn,
                title: order.title,
                order_id: order.id,
                scoring_percent_fl: order.scoring_percent_fl,
                scoring_client_percent_fl: order.scoring_client_percent_fl,
                scoring_upfront_percent: order.scoring_upfront_percent,
                scoring_max_limit: order.scoring_max_limit
              }
            end
          end
        end
      end
    end
  end
end
