if Rails.const_defined?('Console')
  module OpTools
    module DrawTable
      module Presenter
        module PhisicalUser
          class Detailed
            def call(phisical_user)
              {
                id: phisical_user.id,
                fio: phisical_user.fio,
                invite_request_mail: phisical_user.invite_request_mail,
                base_info_email: phisical_user.base_info_email,
                base_info_phone: phisical_user.base_info_phone
              }
            end
          end
        end
      end
    end
  end
end
