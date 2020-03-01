if Rails.const_defined?('Console')
  module OpTools
    module DrawTable
      module Presenter
        module Order
          class NdflRequisites
            def call(order)
              {
                title: order.title,
                inn: order.inn,
                kpp: order.kpp,
                phone: order.phone,
                email: order.email,
                director_fio: order.director_fio,
                key: ::Pvp::OneSAuth.get_key(inn: order.inn)
              }
            end
          end
        end
      end
    end
  end
end
