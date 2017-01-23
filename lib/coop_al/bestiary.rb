require 'singleton'

module CoopAl
  ##
  # Bestiary
  #
  class Bestiary
    include Singleton

    def initialize
      @monsters = {}
      @xp_lookup = XpRewardTable.new
      @loot_generator = LootGenerator.new
    end

    def empty?
      @monsters.empty?
    end

    def add(monster)
      @monsters[monster.id] = monster
    end

    def monster?(id)
      @monsters.key?(id)
    end

    def monster(id)
      @monsters[id]
    end

    def create(id, treasure, encounter)
      raise "Invalid monster ID (#{id})" unless @monsters.key?(id)
      monster = @monsters[id]
      xp = calculate_xp(monster)
      loot = generate_loot(monster, treasure)
      Monster.new(id, xp, loot, encounter)
    end

    private

    def calculate_xp(monster)
      @xp_lookup[monster.cr]
    end

    def generate_loot(monster, treasure)
      return @loot_generator.generate(monster.cr, monster.treasure) if treasure == :default
      @loot_generator.generate(monster.cr, treasure)
    end
  end
end
