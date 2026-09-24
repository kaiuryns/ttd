# frozen_string_literal: true

module Ttd
  module Commands
    # add
    class Add
      DEFAULT = { state: 'todo', priority: 'low', due: nil }.freeze

      def self.run(argv, store)
        options = {}
        parser = Ttd::Commands.option_parse(options)
        names = parser.parse(argv)

        raise ArgumentError, 'add need at least one task' if names.empty?

        tasks = store.load
        apply(tasks, names, options)
        store.save(tasks)
      end

      def self.apply(tasks, names, options)
        names.each do |name|
          key = name.to_sym
          old_options = tasks[key] || {}

          tasks[key] = merge_options(old_options, options)
        end
      end

      def self.merge_options(old_options, options)
        DEFAULT.merge(old_options).merge(options.compact)
      end
    end
  end
end
