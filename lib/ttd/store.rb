# frozen_string_literal: true

module Ttd
  # store
  class Store
    def initialize(path = '.ttd')
      @path = path
    end

    def load
      return {} unless File.exist?(@path)

      JSON.parse(File.read(@path), symbolize_names: true)
    end

    def save(tasks)
      File.write(@path, JSON.pretty_generate(tasks))
    end
  end
end
