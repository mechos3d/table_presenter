if Rails.const_defined?('Console')
  module OpTools
    module DrawTable
      module Presenter
        module Order
          class CompanyRequisites
            def call(order)
              {
                order_id: order.id,
                title: order.title,
                inn: order.inn,
                kpp: order.kpp,
                address: order.company_address,
                phone: order.phone,
                email: order.email,
                director_fio: order.director_fio,
                ogrn: order.ogrn
              }
            end
          end
        end
      end
    end
  end
end
