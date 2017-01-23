module CoopAl
  ##
  # Item
  #
  class Item
    attr_reader :description

    def initialize(count, description, encounter)
      @count = count
      @description = description
      @encounter = encounter
    end

    def to_s
      if @count == 1
        @description
      else
        "#{@description} (#{@count})"
      end
    end

    def description_with_origin
      "#{self} (from #{origin})"
    end

    def origin
      @encounter.full_name
    end
  end
end
