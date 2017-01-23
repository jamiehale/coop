module CoopAl
  ##
  # Encounter
  #
  class Encounter
    attr_reader :name

    def initialize(name, parent)
      @name = name
      @parent = parent
      @monsters = []
      @xp = 0
      @loot = Loot.empty
      @sub_encounters = []
    end

    def adventure_name
      @parent.adventure_name
    end

    def full_name
      if @parent.nil?
        @name
      else
        @parent.full_name + ' - ' + @name
      end
    end

    def add_sub_encounter(encounter)
      @sub_encounters << encounter
    end

    def add_monster(monster)
      @monsters << monster
    end

    def add_treasure(treasure)
      @loot.add_treasure(treasure)
    end

    def add_item(item)
      @loot.add_item(item)
    end

    def add_xp(amount)
      @xp += amount
    end

    def run(state, log)
      run_sub_encounters(state, log)
      trace unless empty?
      log.record_encounter(adventure_name, full_name, monster_names, total_xp, total_loot)
      state.add_xp(total_xp)
      state.add_loot(total_loot)
    end

    def empty?
      @monsters.empty? && @xp.zero? && @loot.empty?
    end

    private

    def trace
      Trace.instance.info("Encounter: #{full_name}")
      Trace.instance.info("Fighting: #{all_monster_names}") unless @monsters.empty?
      trace_xp
      trace_loot
    end

    def trace_xp
      Trace.instance.info("Monster XP: #{monster_xp}") unless @monsters.empty?
      Trace.instance.info("Encounter XP: #{encounter_xp}") unless @xp.zero?
    end

    def trace_loot
      trace_treasure
      trace_items
    end

    def trace_treasure
      Trace.instance.info("Encounter Treasure: #{encounter_treasure}") unless encounter_loot.treasures.empty?
      Trace.instance.info("Monster Treasure: #{monster_treasure}") unless monster_loot.treasures.empty?
    end

    def trace_items
      Trace.instance.info("Encounter Items: #{encounter_items}") unless encounter_loot.items.empty?
      Trace.instance.info("Monster Items: #{monster_items}") unless monster_loot.items.empty?
    end

    def all_monster_names
      @monsters.map(&:id).join(', ')
    end

    def total_xp
      encounter_xp + monster_xp
    end

    def encounter_xp
      @xp
    end

    def monster_xp
      @monsters.inject(0) do |total, monster|
        total + monster.xp
      end
    end

    def total_loot
      encounter_loot + monster_loot
    end

    def encounter_loot
      @loot
    end

    def encounter_treasure
      encounter_loot.treasures.map(&:to_s).join(', ')
    end

    def encounter_items
      encounter_loot.items.map(&:to_s).join(', ')
    end

    def monster_loot
      @monsters.inject(Loot.empty) do |loot, monster|
        loot + monster.loot
      end
    end

    def monster_items
      monster_loot.items.map(&:to_s).join(', ')
    end

    def monster_treasure
      monster_loot.treasures.map(&:to_s).join(', ')
    end

    def monster_names
      @monsters.map(&:to_s)
    end

    def run_sub_encounters(state, log)
      @sub_encounters.each do |encounter|
        encounter.run(state, log)
      end
    end
  end
end
