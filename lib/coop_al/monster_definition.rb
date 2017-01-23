module CoopAl
  ##
  # MonsterDefinition
  #
  class MonsterDefinition
    attr_reader :id, :cr, :treasure

    def initialize(id, cr, treasure)
      @id = id
      @cr = cr
      @treasure = treasure
    end

    def ==(other)
      @id == other.id && @cr == other.cr && @treasure == other.treasure
    end
  end
end
