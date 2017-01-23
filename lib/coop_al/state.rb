module CoopAl
  ##
  # State
  #
  class State
    attr_reader :xp, :loot, :items
    attr_accessor :current_path

    def initialize
      @path_stack = [Path.root]
      @xp = 0
      @loot = Loot.empty
      @visited_paths = []
    end

    def current_path
      @path_stack.last
    end

    def path_depth
      @path_stack.size
    end

    def in_downtime?
      current_path.root?
    end

    def available_paths(library)
      all_available_paths(library).select { |p| !@visited_paths.include?(p) }
    end

    def all_available_paths(library)
      if path_depth == 1
        if in_downtime?
          library.all_entries
        else
          chapter = library.resolve(current_path)
          chapter.links + downtime_if_available(chapter)
        end
      else
        chapter = library.resolve(@path_stack[0])
        library.all_entries + chapter.links + downtime_if_available(chapter)
      end
    end

    def downtime_if_available(chapter)
      return [Path.root] if chapter.links_to_downtime? && !in_downtime?
      []
    end

    def apply_path(path)
      if path_depth == 1
        if path.root?
          @path_stack.push(path)
        else
          @path_stack = [current_path + path]
          @visited_paths << current_path
        end
      else
        @path_stack = [path]
        @visited_paths << path
      end
    end

    def add_xp(xp)
      @xp += xp
    end

    def add_loot(loot)
      @loot += loot
    end

    def add_items(items)
      @items.concat(items)
    end

    def treasure_value
      @treasure.inject(Value.new) { |a, e| a + e.value }
    end

    def history_includes?(path)
      @visited_paths.include?(path)
    end
  end
end
