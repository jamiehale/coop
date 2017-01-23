module CoopAl
  ##
  # Chapter
  #
  class Chapter
    attr_reader :name, :description, :encounters, :links

    def initialize(name, description, adventure)
      @name = name
      @description = description
      @adventure = adventure
      @encounters = []
      @links = []
      @links_to_downtime = false
    end

    def adventure_name
      @adventure.description
    end

    def add_encounter(encounter)
      @encounters << encounter
    end

    def add_link(path)
      @links << path
    end

    def link_to_downtime
      @links_to_downtime = true
    end

    def links_to_downtime?
      @links_to_downtime
    end

    def follow(state, log)
      @encounters.each do |encounter|
        encounter.run(state, log)
      end
    end

    def absolute_path
      Path.Absolute(@adventure.name, @name)
    end

    def full_name
      @adventure.full_name + ' - ' + @description
    end
  end
end
