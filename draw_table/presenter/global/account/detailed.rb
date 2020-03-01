if Rails.const_defined?('Console')
  module OpTools
    module DrawTable
      module Presenter
        module Global
          module Account
            class Detailed
              def call(account)
                {
                  id: account.id,
                  bik: account.bik,
                  ean: account.ean,
                  inn: account.inn,
                  name: account.name,
                  bank_name: account.bank_name,
                  current_balance: fetch_balance(account),
                  closed: account.closed
                }
              end

              private

              def fetch_balance(account)
                account.account_type =~ /alfa/ ? account.current_balance : 'Н/д для в/с'
              end
            end
          end
        end
      end
    end
  end
end
