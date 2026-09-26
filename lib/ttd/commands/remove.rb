# frozen_string_literal: true

module Ttd
  module Commands
    # remove
    class Remove
      def self.run(argv, store)
        parser = Ttd::Commands.option_parse({})
        names = parser.parse(argv)

        raise ArgumentError, 'remove need at least one task or pattern' if names.empty?

        tasks = store.load
        matches = collect(tasks, names)

        if matches.empty?
          puts 'nothing to remove'
          return
        end

        return unless Ttd::Commands.cconfirm_deletion?(matches)

        matches.each_key { |key| tasks.delete(key) }
        store.save(tasks)
      end

      def self.collect(tasks, names)
        keys = names.flat_map { |name| resolve(tasks, name) }
        tasks.slice(*keys)
      end

      def self.resolve(tasks, name)
        if name.start_with?('/') && name.end_with?('/')
          pattern = Regexp.new(name[1..-2])
          tasks.keys.select { |key| key.to_s.match?(pattern) }
        else
          [name.to_sym]
        end
      end
    end
  end
end
