# frozen_string_literal: true

COMMANDS = {
  'add' => Ttd::Commands::Add,
  'remove' => Ttd::Commands::Remove,
  'next' => Ttd::Commands::Next,
  'before' => Ttd::Commands::Before,
  'up' => Ttd::Commands::Up,
  'down' => Ttd::Commands::Down,
  'clear' => Ttd::Commands::Clear
}.freeze

module Ttd
  # cli
  class CLI
    def self.run(argv)
      store = Store.new

      verb = argv[0]
      if verb.nil? || verb.start_with?('--')
        Commands::Show.run(argv, store)
      elsif COMMANDS.key?(verb)
        COMMANDS[verb].run(argv[1..], store)
      else
        raise ArgumentError, "unknown command: #{verb}"
      end
    end
  end
end
