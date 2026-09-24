# frozen_string_literal: true

module Ttd
  module Commands
    # add
    class Add
      def self.run(argv, store)
        options = { state: 'todo', priority: 'low', due: nil }

        parser = OptParse.new do |opts|
          opts.on('--state STATE', Ttd::STATES, "state (#{Ttd::STATES.join('/')})") do |v|
            options[:state] = v
          end

          opts.on('--priority PRIORITY', Ttd::PRIORITIES, "priority (#{Ttd::PRIORITIES.join('/')}") do |v|
            options[:priority] = v
          end
          opts.on('--due DUE') do |v|
            options[:due] = Ttd::DueParser.parse(v)
          end
        end

        parser.parse(argv)

        tasks = store.load

        names.each do |name|
          tasks[name.to_sym] = {
            state: options[:state],
            priority: options[:priority],
            due: options[:due]
          }
        end

        store.save(tasks)
      end
    end
  end
end
