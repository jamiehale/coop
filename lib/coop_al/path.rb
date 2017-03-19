module CoopAl
  ##
  # Path
  #
  class Path
    attr_reader :adventure, :chapter

    def initialize(adventure, chapter)
      @adventure = adventure
      @chapter = chapter
    end

    def root?
      @adventure.nil? && @chapter.nil?
    end

    def relative?
      @adventure.nil? && !@chapter.nil?
    end

    def absolute?
      !relative?
    end

    def self.absolute(adventure, chapter)
      Path.new(adventure, chapter)
    end

    def self.relative(chapter)
      Path.new(nil, chapter)
    end

    def self.root
      Path.new(nil, nil)
    end

    def self.parse(path)
      tokens = path.split('/').map(&:to_sym)
      raise "Invalid path #{path}" if tokens.count > 2
      return absolute(tokens[0], tokens[1]) if tokens.count == 2
      return root if tokens[0] == :downtime
      relative(tokens[0])
    end

    def ==(other)
      to_s == other.to_s
    end

    def <=>(other)
      to_s <=> other.to_s
    end

    def +(other)
      local_path = other.is_a?(Path) ? other : Path.parse(other)
      return local_path if local_path.absolute?
      raise 'Cannot add two relative paths' if relative?
      Path.absolute(@adventure, other.chapter)
    end

    def to_s
      adventure_s + @chapter.to_s
    end

    def adventure_s
      return @adventure.to_s + '/' if absolute?
      ''
    end
  end
end
