module CoopAl
  ##
  # Session
  #
  class Session
    attr_reader :number, :adventure_name, :dm_name, :starting_xp, :starting_treasure, :encounters

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

    def date
      @date_generator.session(@number)
    end

    def xp_earned
      @encounters.inject(0) { |a, e| a + e.xp }
    end

    def xp_total
      @starting_xp + xp_earned
    end

    def treasure_earned
      @encounters.inject(Value.new) { |a, e| a + e.treasure }
    end

    def treasure_total
      @starting_treasure + treasure_earned
    end

    def starting_level
      level(@starting_xp)
    end

    def ending_level
      level(xp_total)
    end

    private

    def level(xp)
      XpRequirementTable.new.level_from_xp(xp)
    end
  end
end
