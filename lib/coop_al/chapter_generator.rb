module CoopAl
  ##
  # ChapterGenerator
  #
  class ChapterGenerator
    attr_reader :chapter

    def initialize(name, description, adventure, bestiary)
      @adventure = adventure
      @chapter = Chapter.new(name, description, adventure)
      @bestiary = bestiary
    end

    def encounter(name, &blk)
      generator = EncounterGenerator.new(name, @chapter, @bestiary)
      @chapter.add_encounter(generator.generate_encounter(&blk))
    end

    def random(name, &blk)
      generator = RandomEncounterGenerator.new(name, @chapter, @bestiary)
      @chapter.add_encounter(generator.generate_encounter(&blk))
    end

    def link_to(chapter)
      @chapter.add_link(Path.absolute(@adventure.name, chapter))
    end

    def link_to_downtime
      @chapter.link_to_downtime
    end
  end
end
