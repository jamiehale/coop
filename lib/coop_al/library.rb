require 'singleton'

module CoopAl
  ##
  # Library
  #
  class Library
    include Singleton

    def initialize
      @adventures = {}
    end

    def empty?
      @adventures.empty?
    end

    def add_adventure(adventure)
      raise Exception, 'Duplicate adventure' if @adventures.key?(adventure.name)
      @adventures[adventure.name] = adventure
    end

    def adventure?(name)
      @adventures.key?(name)
    end

    def adventure(name)
      @adventures[name]
    end

    def path?(path)
      raise Exception, "Cannot resolve relative path (#{path})" if path.relative?
      return false unless @adventures.key?(path.adventure)
      @adventures[path.adventure].chapter?(path.chapter)
    end

    def resolve(path)
      raise Exception, "Adventure (#{path.adventure}) not found" unless @adventures.key?(path.adventure)
      @adventures[path.adventure].chapter(path.chapter)
    end

    def all_entries
      @adventures.values.inject([]) { |a, e| a + e.all_entries }
    end

    def available_paths_from(path)
      return all_entries if path.root?
      current_chapter = resolve(path)
      paths = current_chapter.links
      paths << Path.root if current_chapter.links_to_downtime?
      paths
    end
  end
end
