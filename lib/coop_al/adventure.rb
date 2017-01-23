module CoopAl
  ##
  # Adventure
  #
  class Adventure
    attr_reader :name, :description, :chapters

    def initialize(name, description)
      @name = name
      @description = description
      @entries = []
      @chapters = {}
    end

    def add_entry(path)
      @entries << path
    end

    def add_chapter(chapter)
      @chapters[chapter.name] = chapter
    end

    def all_chapter_names
      @chapters.keys
    end

    def chapter_by_path(path)
      @chapters[path.chapter]
    end

    def chapter_paths
      @chapters.values.map(&:absolute_path)
    end

    def all_entries
      @entries.map { |e| Path.absolute(@name, e) }
    end

    def chapter?(name)
      @chapters.key?(name)
    end

    def chapter(name)
      raise "Chapter (#{name}) not found" unless @chapters.key?(name)
      @chapters[name]
    end

    def full_name
      @description
    end
  end
end
