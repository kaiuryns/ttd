# frozen_string_literal: true

module Ttd
  module Commands
    # show
    class Show
      def self.run(argv, store)
        parser = Ttd::Commands.option_parse({})
        names = parser.parse(argv)

        raise ArgumentError, 'dont accept tasks' unless names.empty?

        tasks = store.load
        puts JSON.pretty_generate(tasks)
      end
    end
  end
end
