if Rails.const_defined?('Console')
  module OpTools
    module DrawTable
      module Presenter
        module Global
          module TaxService
            class Detailed
              def call(tax_service)
                {
                  id: tax_service.id,
                  name: tax_service.name,
                  code: tax_service.code,
                  kpp: tax_service.kpp,
                  okato: tax_service.okato
                }
              end
            end
          end
        end
      end
    end
  end
end
