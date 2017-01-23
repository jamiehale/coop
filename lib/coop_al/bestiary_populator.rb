module CoopAl
  ##
  # BestiaryPopulator
  #
  class BestiaryPopulator
    def initialize(&blk)
      instance_eval(&blk)
    end

    def add(id, cr, treasure = :individual)
      Bestiary.instance.add(MonsterDefinition.new(id, cr, treasure))
    end
  end
end
