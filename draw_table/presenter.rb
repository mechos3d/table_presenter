if Rails.const_defined?('Console')
  require_relative 'presenter/pvp_loan/short.rb'
  require_relative 'presenter/pvp_loan/detailed.rb'

  module OpTools
    module DrawTable
      module Presenter
        class << self
          def get(entity, presenter_type = :short)
            "#{self}::#{entity.class}::#{presenter_type.to_s.camelize}".constantize
          end
        end
      end
    end
  end
end
