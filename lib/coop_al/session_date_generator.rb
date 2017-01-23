module CoopAl
  ##
  # SessionDateGenerator
  #
  class SessionDateGenerator
    def initialize(options)
      @next_date = options[:end_date]
      @session_frequency = options[:session_frequency]
      @skip_frequency = options[:skip_frequency]
      @sessions = []
      @blackout_dates = options[:blackout_dates]
    end

    def add_session
      @sessions.push(@next_date)
      advance_next_date
    end

    def session(number)
      @sessions[-number]
    end

    private

    def advance_next_date
      loop do
        @next_date -= @session_frequency
        break if ok?(@next_date)
      end
    end

    def ok?(date)
      return false if @blackout_dates.include?(date)
      return true if @skip_frequency.nil?
      return false if roll_dice("d#{@skip_frequency}") == 1
      true
    end

    def blackout?(date)
      @blackout_dates.include?(date)
    end
  end
end
