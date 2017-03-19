module CoopAl
  ##
  # EncounterGenerator
  #
  class EncounterGenerator
    def initialize(name, parent, bestiary)
      @bestiary = bestiary
      @encounter = Encounter.new(name, parent)
    end

    def generate_encounter(&blk)
      instance_eval(&blk)
      @encounter
    end

    def monsters(count, id, treasure = :default)
      expand_count(count).times do
        @encounter.add_monster(@bestiary.create(id, treasure, @encounter))
      end
    end

    def monster(id, treasure = :default)
      monsters(1, id, treasure)
    end

    def treasure(value, description = nil)
      @encounter.add_treasure(Treasure.new(value, description))
    end

    def items(count, description)
      @encounter.add_item(Item.new(expand_count(count), description, @encounter))
    end

    def item(description)
      items(1, description)
    end

    def encounter(name, &blk)
      generator = EncounterGenerator.new(name, @encounter, @bestiary)
      @encounter.add_sub_encounter(generator.generate_encounter(&blk))
    end

    def random(name, &blk)
      generator = RandomEncounterGenerator.new(name, @encounter, @bestiary)
      @encounter.add_sub_encounter(generator.generate_encounter(&blk))
    end

    def xp(amount)
      @encounter.add_xp(amount)
    end

    def npc(cr)
      xp(XpRewardTable.new[cr])
    end

    def npcs(count, cr)
      xp(count * XpRewardTable.new[cr])
    end

    private

    def expand_count(count)
      return roll(count) if count.is_a?(String)
      count
    end
  end
end
