module CoopAl
  ##
  # Session
  #
  class Session
    def initialize(number, date_generator, adventure_name, dm_name, starting_xp, starting_treasure, encounter_count)
      @number = number
      @date_generator = date_generator
      @adventure_name = adventure_name
      @dm_name = dm_name
      @starting_xp = starting_xp
      @starting_treasure = starting_treasure
      @encounter_count = encounter_count
      @encounters = []

      @date_generator.add_session
    end

    def add_encounter(encounter)
      @encounters << encounter
    end

    def done?
      @encounters.count { |e| e.counts? } == @encounter_count
    end

    def dump(s)
      s.puts "Adventure: #{@adventure_name}"
      s.puts "Session ##{@number}: #{@date_generator.session(@number)}"
      s.puts "DM: #{@dm_name}"
      s.puts "Starting XP: #{@starting_xp} (level #{level(@starting_xp)})"
      s.puts "XP Earned: #{xp_earned}"
      s.puts "XP Total: #{@starting_xp + xp_earned} (level #{level(@starting_xp + xp_earned)})"
      s.puts "Starting Treasure: #{@starting_treasure}"
      s.puts "Treasure +/-: #{treasure_earned}"
      s.puts "Treasure Total: #{@starting_treasure + treasure_earned}"
      @encounters.each { |e| e.dump(s) if e.counts? }
      s.puts
    end

    private

    def xp_earned
      @encounters.inject(0) { |a, e| a + e.xp }
    end

    def treasure_earned
      @encounters.inject(Value.new) { |a, e| a + e.treasure }
    end

    def level(xp)
      XpRequirementTable.new.level_from_xp(xp)
    end
  end
end
