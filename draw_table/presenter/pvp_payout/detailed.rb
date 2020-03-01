if Rails.const_defined?('Console')
  module OpTools
    module DrawTable
      module Presenter
        module Pvp
          module Payout
            class Detailed
              def call(payout)
                {
                  id: payout.id,
                  operation_time: payout.operation_time,
                  aasm_state: payout.aasm_state,
                  pack_state: payout.global_transaction_pack.aasm_state,
                  payment_type: payout.payment_type,
                  alternative_account_payment: payout.alternative_account_payment,
                  transactions: transactions_by_state(payout)
                }
              end

              private

              def transactions_by_state(payout)
                Array(payout.global_transactions.group(:aasm_state).count)
              end
            end
          end
        end
      end
    end
  end
end
