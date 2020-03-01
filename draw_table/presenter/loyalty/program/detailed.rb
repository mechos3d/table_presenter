if Rails.const_defined?('Console')
  module OpTools
    module DrawTable
      module Presenter
        module Loyalty
          module Program
            class Detailed
              def call(program)
                order = program.order
                {
                  inn: order.inn,
                  title: order.title,
                  order_id: order.id,
                  enabled: program.enabled,
                  available: program.available,
                  date_comparison: program.pvp_company.last_loan.created_at > order.created_at,
                  ready_for_flow: program.ready_for_flow?,
                  actualized_at: program.actualized_at,
                  order_state: order.state,
                  scoring_max_limit: order.scoring_max_limit
                }
              end
            end
          end
        end
      end
    end
  end
end
