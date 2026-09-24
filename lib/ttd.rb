# frozen_string_literal: true

require 'optparse'

require_relative 'ttd/store'
require_relative 'ttd/cli'
Dir[File.expand_path('ttd/commands/*.rb', __dir__)].sort.each { |f| require f }

# entry point
module Ttd
end
