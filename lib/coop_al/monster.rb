module CoopAl
  ##
  # Monster
  #
  class Monster
    attr_reader :id, :xp, :loot, :encounter

    def initialize(id, xp, loot, encounter)
      @id = id
      @xp = xp
      @loot = loot
      @encounter = encounter
    end

    def to_s
      @id.to_s
    end
  end
end
