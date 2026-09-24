# frozen_string_literal: true

module Ttd
  module Commands
    # next
    class Next
      def self.run(argv, store)
        parser = Ttd::Commands.option_parse({})
        names = parser.parse(argv)

        raise ArgumentError, 'next need at least one task' if names.empty?

        tasks = store.load
        apply(tasks, names)
        store.save(tasks)
      end

      def self.apply(tasks, names)
        missing = names.reject { |name| tasks[name.to_sym] }
        raise ArgumentError, "tasks not found:\n#{missing.join("\n")}" unless missing.empty?

        names.each do |name|
          key = name.to_sym
          tasks[key][:state] = next_stage(tasks[key][:state])
        end
      end

      def self.next_stage(current)
        idx = Ttd::Commands::STATES.index(current)
        Ttd::Commands::STATES[[idx + 1, Ttd::Commands::STATES.size - 1].min]
      end
    end
  end
end
