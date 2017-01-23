module CoopAl
  ##
  # RandomEncounterGenerator
  #
  class RandomEncounterGenerator
    def initialize(name, parent, bestiary)
      @name = name
      @parent = parent
      @bestiary = bestiary
      @encounter = RandomEncounter.new(name, parent)
    end

    def generate_encounter(&blk)
      instance_eval(&blk)
      @encounter
    end

    def fixed(*args, &blk)
      generator = EncounterGenerator.new(@name, @parent, @bestiary)
      entry = generator.generate_encounter(&blk)
      if args.empty?
        @encounter.add_entry(entry)
      else
        roll = args.shift
        if roll.is_a?(Integer)
          @encounter.set_entry(roll, entry)
        elsif roll.is_a?(Range)
          @encounter.set_range(roll, entry)
        else
          raise "Inappropriate roll descriptor (#{roll})"
        end
      end
    end

    alias f fixed
  end
end
