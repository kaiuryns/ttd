# frozen_string_literal: true

# ttd
module Ttd
  # due parser
  module Commands
    SHORTCUTS = {
      'today' => 0,
      'tomorrow' => 1,
      'yesterday' => -1
    }.freeze

    STATES = %w[todo wip done].freeze

    PRIORITY = %w[low mid high].freeze

    def self.due_parse(input)
      if SHORTCUTS.key?(input)
        (Date.today + SHORTCUTS[input]).to_s
      elsif input =~ /\A\d{4}-\d{2}-\d{2}\z/
        Date.parse(input).to_s
      elsif input =~ /\A(\d+y)?(\d+m)?(\d+d)?\z/ && input != ''
        parse_relative_duration(input).to_s
      else
        raise ArgumentError, "invalid due date: #{input}"
      end
    end

    def self.parse_relative_duration(input)
      years  = input[/(\d+)y/, 1].to_i
      months = input[/(\d+)m/, 1].to_i
      days   = input[/(\d+)d/, 1].to_i

      Date.today >> ((years * 12) + months)
                    .then { |d| d + days }
    end

    def self.option_parse(options)
      OptionParser.new do |opts|
        opts.on('--state STATE', Ttd::STATES) { |v| options[:state] = v }
        opts.on('--priority PRIORITY', Ttd::PRIORITIES) { |v| options[:priority] = v }
        opts.on('--due DUE') { |v| options[:due] = Ttd::Commands.due_parse(v) }
      end
    end

    def self.confirm_deletion?(matches)
      puts JSON.pretty_generate(matches)
      print 'delete these tasks? [y/N]: '
      $stdin.gets.chomp == 'y'
    end
  end
end
