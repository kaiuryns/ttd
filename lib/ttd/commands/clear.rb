# frozen_string_literal: true

module Ttd
  module Commands
    # clear
    class Clear
      DEFAULT = { state: 'todo', priority: 'low', due: nil }.freeze

      def self.run(argv, store)
        options = {}
        parser = Ttd::Commands.option_parse(options)
        names = parser.parse(argv)

        raise ArgumentError, 'dont accept tasks' unless names.empty?

        tasks = store.load

        matches = collect(tasks, options)

        if matches.empty?
          puts 'nothing to clear'
          return
        end

        return unless Ttd::Commands.confirm_deletion?(matches)

        matches.each_key { |key| tasks.delete(key) }

        store.save(tasks)
      end

      def self.collect(tasks, options)
        filters = options.compact
        filters = { state: 'done' } if filters.empty?

        tasks.select { |_key, task| matches?(task, filters) }
      end

      def self.matches?(task, filters)
        filters.all? do |field, value|
          if field == :due
            !task[:due].nil? &&
              task[:due] <= value
          else
            task[field] == value
          end
        end
      end
    end
  end
end
