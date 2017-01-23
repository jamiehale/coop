module CoopAl
  ##
  # AdventureGenerator
  #
  class AdventureGenerator
    attr_reader :adventure

    def initialize(name, description, bestiary)
      initialize_adventure(name, description)
      @bestiary = bestiary
    end

    def entry(name)
      @adventure.add_entry(name)
    end

    def chapter(name, description, &blk)
      generator = ChapterGenerator.new(name, description, @adventure, @bestiary)
      generator.instance_eval(&blk)
      @adventure.add_chapter(generator.chapter)
    end

    private

    def initialize_adventure(name, description)
      if Library.instance.adventure?(name)
        @adventure = Library.instance.adventure(name)
      else
        raise "Description required for adventure (#{name})" if description.nil?
        @adventure = Adventure.new(name, description)
        Library.instance.add_adventure(@adventure)
      end
    end
  end
end
