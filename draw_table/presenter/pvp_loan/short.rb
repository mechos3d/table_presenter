if Rails.const_defined?('Console')
  module OpTools
    module DrawTable
      module Presenter
        module Pvp
          module Loan
            class Short
              def call(loan)
                {
                  id: 'id',
                  t_year: loan.t_year
                }
              end
            end
          end
        end
      end
    end
  end
end
