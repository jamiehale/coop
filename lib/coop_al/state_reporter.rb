module CoopAl
  ##
  # StateReporter
  #
  class StateReporter
    def initialize(state, library, options = {})
      @state = state
      @library = library
      @party_size = options.key?(:party_size) ? options[:party_size] : 6
      @show_xp = options.key?(:show_xp) ? options[:show_xp] : true
      @show_loot = options.key?(:show_loot) ? options[:show_loot] : true
      @show_paths = options.key?(:show_paths) ? options[:show_paths] : true
    end

    def report(s)
      report_xp(s) if @show_xp
      report_loot(s) if @show_loot
      report_paths(s) if @show_paths
    end

    private

    def report_xp(s)
      s.puts "Character Level: #{character_level} (#{character_xp} XP - #{@state.xp} XP total)"
    end

    def character_xp
      @state.xp / @party_size
    end

    def character_level
      CoopAl::XpRequirementTable.new.level_from_xp(character_xp)
    end

    def report_loot(s)
      report_treasure(s)
      report_items(s)
    end

    def report_treasure(s)
      return if @state.loot.treasures.empty?
      s.puts "Treasure: #{character_treasure} (#{@state.loot.treasure_value} total)"
    end

    def report_items(s)
      items = @state.loot.items
      return if items.empty?
      s.puts 'Items:'
      s.puts items.map { |item| "  #{item.description_with_origin}" }
    end

    def character_treasure
      @state.loot.treasure_value / @party_size
    end

    def report_paths(s)
      s.puts 'Paths:'
      if available_paths.empty?
        s.puts '  None'
      else
        s.puts available_paths.map { |p| "  #{p}" }.join("\n")
      end
    end

    def available_paths
      @state.available_paths(@library).sort.map do |p|
        if p.root?
          'Downtime (downtime)'
        else
          "#{@library.resolve(p).description} (#{p})"
        end
      end
    end
  end
end
