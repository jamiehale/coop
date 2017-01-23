module CoopAl
  ##
  # PathFollower
  #
  class PathFollower
    attr_reader :state

    def initialize(library, starting_state)
      @library = library
      @state = starting_state
    end

    def follow(paths, log)
      paths.each do |path|
        follow_path(path, log)
      end
      @state
    end

    private

    def follow_path(path, log)
      if path.root?
        log.record_downtime(@library.resolve(@state.current_path).adventure_name)
        @state.apply_path(path)
      else
        raise Exception, "#{path} not a valid next path" unless @library.path?(@state.current_path + path)
        raise Exception, "Cannot repeat path (#{path})" if @state.history_includes?(@state.current_path + path)
        @state.apply_path(path)
        @library.resolve(@state.current_path).follow(@state, log)
      end
    end
  end
end
