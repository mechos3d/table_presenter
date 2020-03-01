if Rails.const_defined?('Console')
  module OpTools
    module DrawTable
      module Presenter
        module Global
          module Transaction
            class Detailed
              def call(transaction)
                {
                  id: transaction.id,
                  aasm_state: transaction.aasm_state,
                  was_uid: transaction.was_uid,
                  amount: transaction.amount,
                  cached_answer: parse_cached_answer(transaction),
                  purpose: transaction.purpose,
                  target_type: transaction.target_type,
                  source_type: transaction.source_type
                }
              end

              private

              def parse_cached_answer(transaction)
                cached_answer = transaction.cached_answer
                # Считаем, что если есть скобка, то это хэш ошибки строкой - надо парсить
                if cached_answer.present? && cached_answer.include?('{')
                  begin
                    answer_hash = JSON.parse(cached_answer.gsub('=>', ':'))
                    [:fault, answer_hash.dig('fault', 'faultstring')]
                  rescue
                    'Ошибка парсинга'
                  end
                else
                  cached_answer
                end
              end
            end
          end
        end
      end
    end
  end
end
