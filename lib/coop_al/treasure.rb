module CoopAl
  ##
  # Treasure
  #
  class Treasure
    attr_reader :value

    def initialize(value, description = nil)
      @value = value
      @description = description
    end

    def to_s
      if @description.nil?
        "coins (#{@value})"
      else
        "#{@description} (#{@value})"
      end
    end
  end
end
