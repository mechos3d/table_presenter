if Rails.const_defined?('Console')
  module OpTools
    module DrawTable
      module Presenter
        module Pvp
          module Loan
            class Detailed
              attr_reader :loan, :current_date

              def call(loan, current_date = Date.current) # rubocop:disable Metrics/AbcSize
                @loan = loan
                @current_date = current_date
                {
                  id:          loan.id,
                  title:       order.title,
                  inn:         loan.tax_agent_id,
                  flow_type:   loan.flow_type,
                  aasm_state:  loan.aasm_state,
                  started_at:  loan.started_at,
                  active_debt: money_fmt(cached_state.active_debt),
                  d_loan_left: money_fmt(cached_state.d_loan_left),
                  payouts:     payouts.group_by(&:aasm_state).map { |k, v| [k, v.count] },
                  last_payout_operation_time: payouts.max_by(&:operation_time)&.operation_time,
                  ended_at:           loan.repaid_at || loan.wait_for_returns_at,
                  payout_acc_balance: money_fmt(payout_account.current_balance),
                  payout_acc_type:    payout_account.class.to_s,
                  near_payments: near_payments
                }
              end

              private

              def money_fmt(num)
                return if num.nil?
                str = num.to_s
                return num unless str.size > 1
                str2 = str.reverse
                (str2[0..1] + str2[2..-1].split('').map.with_index { |x, i| i % 3 == 0 ? "_#{x}" : x }.join).reverse
              end

              def near_payments
                d_start = current_date - loan.t_period.days
                d_end = current_date + loan.t_period.days
                loan.period_start_dates.map { |x| Date.parse(x) }.select { |date| date >= d_start && date <= d_end }
              end

              def payout_account
                @_payout_account ||= loan.payout_account
              end

              def payouts
                @_payouts ||= ::Pvp::Payout.where(pvp_loan: loan.id).order(created_at: :asc).to_a
              end

              def order
                @_order ||= loan.order
              end

              def cached_state
                @_cached_state ||= loan.cached_state
              end
            end
          end
        end
      end
    end
  end
end
