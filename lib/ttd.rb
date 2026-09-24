# frozen_string_literal: true

require 'date'
require 'json'
require 'optparse'

require_relative 'ttd/store'
require_relative 'ttd/cli'
require_relative 'ttd/due_parser'

Dir[File.expand_path('ttd/commands/*.rb', __dir__)].sort.each { |f| require f }

# entry point
module Ttd
  STATES = %w[todo wip done].freeze
  PRIORITIES = %w[low mid high].freeze
end
