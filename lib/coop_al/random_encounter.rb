module CoopAl
  ##
  # RandomEncounter
  #
  class RandomEncounter
    def initialize(name, parent)
      @name = name
      @parent = parent
      @entries = []
    end

    def add_entry(entry)
      @entries << entry
    end

    def set_entry(roll, entry)
      @entries[roll - 1] = entry
    end

    def set_range(range, entry)
      range.each do |i|
        set_entry(i, entry)
      end
    end

    def run(state, log)
      @entries[roll("d#{@entries.count}") - 1].run(state, log)
    end
  end
end
