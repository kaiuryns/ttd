# frozen_string_literal: true

# ttd
module Ttd
  # due parser
  module DueParser
    SHORTCUTS = {
      'today' => 0,
      'tomorrow' => 1,
      'yesterday' => -1
    }.freeze

    def self.parse(input)
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
  end
end
