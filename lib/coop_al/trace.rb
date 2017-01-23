require 'singleton'

module CoopAl
  ##
  # Trace
  #
  class Trace
    include Singleton

    attr_writer :tracing, :stream

    def initialize
      @tracing = false
      @stream = STDOUT
    end

    def info(s)
      @stream.puts(s) if @tracing
    end

    def warn(s)
      @stream.puts("[WARNING] #{s}") if @tracing
    end

    def error(s)
      @stream.puts("[ERROR] #{s}") if @tracing
    end
  end
end
