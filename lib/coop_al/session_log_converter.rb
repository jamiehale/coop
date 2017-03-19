module CoopAl
  ##
  # SessionLogConverter
  #
  class SessionLogConverter
    def to_obj(log)
      {
        'sessions' => sessions_to_array(log.sessions)
      }
    end

    def sessions_to_array(sessions)
      sessions.inject([]) do |a, e|
        a + [session_to_obj(e)]
      end
    end

    def session_to_obj(session)
      {
        'adventure' => session.adventure_name,
        'number' => session.number,
        'date' => session.date,
        'dm_name' => session.dm_name,
        'starting_xp' => session.starting_xp,
        'xp_earned' => session.xp_earned,
        'xp_total' => session.xp_total,
        'starting_treasure' => session.starting_treasure.to_s,
        'treasure_earned' => session.treasure_earned.to_s,
        'total_treasure' => session.treasure_total.to_s,
        'starting_level' => session.starting_level,
        'ending_level' => session.ending_level,
        'encounters' => encounters_to_array(session.encounters)
      }
    end

    def encounters_to_array(encounters)
      encounters.inject([]) do |a, e|
        a + [encounter_to_obj(e)]
      end
    end

    def encounter_to_obj(encounter)
      {
        'name' => encounter.name,
        'monsters' => encounter.monsters_s,
        'xp' => encounter.xp,
        'treasure' => encounter.treasure.to_s,
        'items' => encounter.items.map(&:to_s)
      }
    end
  end
end
