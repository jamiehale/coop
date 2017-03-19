module CoopAl
  ##
  # SessionLog
  #
  class SessionLog
    attr_reader :sessions

    def initialize(date_generator, options)
      @date_generator = date_generator
      @encounter_count = options[:encounter_count]
      @party_size = options[:party_size]
      @dm_name = options[:dm_name]
      @accumulated_xp = 0
      @accumulated_treasure = Value.new
      @sessions = []
    end

    def record_encounter(adventure_name, encounter_name, monsters, xp, loot)
      ensure_active_session(adventure_name)
      @accumulated_xp += xp / @party_size
      @accumulated_treasure += loot.treasure_value / @party_size
      active_session.add_encounter(SessionEncounter.new(encounter_name, monsters, xp / @party_size, loot.treasure_value / @party_size, loot.items.dup))
    end

    def record_downtime(adventure_name)
      ensure_active_session(adventure_name)
      active_session.add_encounter(Downtime.new)
    end

    def dump(s)
      @sessions.each { |e| e.dump(s) }
      s.puts "Session Count: #{@sessions.size}"
    end

    private

    def ensure_active_session(adventure_name)
      start_new_session(adventure_name) if @sessions.empty? || active_session.done?
    end

    def active_session
      @sessions.last
    end

    def start_new_session(adventure_name)
      @sessions.push(Session.new(session_number, @date_generator, adventure_name, @dm_name, @accumulated_xp, @accumulated_treasure.dup, @encounter_count))
    end

    def session_number
      @sessions.size + 1
    end
  end
end
