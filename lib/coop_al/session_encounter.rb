module CoopAl
  ##
  # SessionEncounter
  #
  class SessionEncounter
    attr_reader :name, :xp, :treasure, :items

    def initialize(name, monsters, xp, treasure, items)
      @name = name
      @monster_counts = monster_counts(monsters)
      @monsters = monsters.uniq.sort
      @xp = xp
      @treasure = treasure
      @items = items
    end

    def counts?
      @xp.nonzero?
    end

    def monsters_s
      @monsters.map { |m| pluralize(m, @monster_counts[m]) }.join(', ')
    end

    def dump(s)
      s.puts "Encounter: #{@name}"
      s.puts " Monsters: #{monsters_s}"
      s.puts " XP: #{@xp}"
      s.puts " Treasure: #{@treasure}" unless @treasure.zero?
      s.puts " Items: #{items_s}" unless @items.empty?
    end

    private

    def monster_counts(monsters)
      results = {}
      monsters.each do |m|
        if results.key?(m)
          results[m] += 1
        else
          results[m] = 1
        end
      end
      results
    end

    def pluralize(monster, count)
      return monster if count == 1
      "#{monster} (#{count})"
    end

    def items_s
      @items.map(&:to_s).join(', ')
    end
  end

  ##
  # Downtime
  #
  class Downtime
    def xp
      0
    end

    def treasure
      Value.new
    end

    def counts?
      true
    end

    def dump(s)
      s.puts 'Downtime'
    end
  end
end
