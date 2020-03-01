if Rails.const_defined?('Console')
  # rubocop:disable Rails/Output
  require 'ostruct'
  require_relative 'draw_table/presenter'

  # USAGE EXAMPLE:
  # # OpTools::DrawTable.new.ddraw_t([{ a: 11111, b: 2222, c: 3333 },
  #                                   { a: 111112222, b: 22223333, c: 3333444 },
  #                                   { a: 1111133, b: 222244, c: 333355 }])

  # TODO: вынести отсюда абстрактный отрисовщик таблиц (метод draw_table и его вспомогательные методы)
  module OpTools
    module DrawTable
      # NOTE: показывает таблицей массив объектов или один объект
      def tt(obj, args = {})
        return if obj.blank?
        default_args = if obj.is_a?(Array) || obj.is_a?(ActiveRecord::Relation)
                         { presenter: :short, type: :hor }
                       else
                         { presenter: :detailed, type: :ver }
                       end
        ddraw_t(Array(obj), default_args.merge(args))
      end

      def tp(obj, presenter)
        tt(obj, presenter: presenter)
      end

      private

      # EXAMPLE:
      # ddraw_t(payouts, type: :hor, presenter: :short)
      # ddraw_t(loans, type: :ver, presenter: :detailed)
      def ddraw_t(objects, args = {})
        default_args = { type: :hor, presenter: nil, sort: nil }
        new_args = default_args.merge(args)
        met = { hor: :horizontal, ver: :vertical }[new_args[:type]]
        send(met, prepare_array(objects, new_args[:presenter]))
        objects.size
      end

      # TODO: сделать сортировку
      def prepare_array(objects, presenter_type)
        return objects if objects.blank? || objects.first.is_a?(Hash) # NOTE: если это уже массив хэшей
        presenter_class = Presenter.get(objects.first, presenter_type)
        objects.map { |obj| presenter_class.new.call(obj) }
      end

      # NOTE: принимает на вход массив хэшей
      def vertical(objects_arr)
        attrs = objects_arr.first.keys
        table_cells = attrs.map do |atr|
          [atr] + objects_arr.map { |x| x[atr] }
        end
        draw_table(table_cells)
      end

      # NOTE: принимает на вход массив хэшей
      def horizontal(objects_arr)
        headers = objects_arr.first.keys
        table_cells = [headers] + objects_arr.map(&:values)
        draw_table(table_cells)
      end

      def draw_table(table_cells)
        max_sizes = calculate_max_column_sizes(table_cells)

        row_strings = table_cells.map { |arr| compose_string(arr, max_sizes) }

        hor_separator_line = '-' * row_strings[0].size

        final_res = row_strings.map do |el|
          el + "\n" + hor_separator_line
        end.join("\n")

        final_res = hor_separator_line + "\n" + final_res
        puts final_res
      end

      def calculate_max_column_sizes(table_cells)
        max_sizes = table_cells.first.map { 0 }

        table_cells.each do |el|
          el.each_with_index do |x, i|
            size = x.to_s.size
            max_sizes[i] = size if max_sizes[i] < size
          end
        end
        max_sizes
      end

      def compose_string(arr, max_sizes)
        res = arr.each_with_index.map do |el, i|
          str = el.to_s
          diff = max_sizes[i] - str.size
          str + ' ' * diff
        end
        "| #{res.join(' | ')} |"
      end
    end
  end
end
# rubocop:enable Rails/Output
