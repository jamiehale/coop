module CoopAl
  ##
  # TextSessionLogFormater
  #
  class TextSessionLogFormatter
    def initialize(stream)
      @stream = stream
    end

    def write(log)
      obj = SessionLogConverter.new.to_obj(log)
      @stream.write(to_text(obj))
    end

    private

    def to_text(obj)
      obj['sessions'].each do |session|
        dump_session(session)
      end
      @stream.puts "Session Count: #{obj['sessions'].size}"
    end

    def dump_session(session)
      @stream.puts "Adventure: #{session['adventure']}"
      @stream.puts "Session ##{session['number']}: #{session['date']}"
      @stream.puts "DM: #{session['dm_name']}"
      @stream.puts "Starting XP: #{session['starting_xp']} (level #{session['starting_level']})"
      @stream.puts "XP Earned: #{session['xp_earned']}"
      @stream.puts "XP Total: #{session['xp_total']} (level #{session['ending_level']})"
      @stream.puts "Starting Treasure: #{session['starting_treasure']}"
      @stream.puts "Treasure +/-: #{session['treasure_earned']}"
      @stream.puts "Treasure Total: #{session['total_treasure']}"
      dump_encounters(session['encounters'])
      @stream.puts
    end

    def dump_encounters(encounters)
      encounters.each do |encounter|
        dump_encounter(encounter)
      end
    end

    def dump_encounter(encounter)
      @stream.puts "Encounter: #{encounter['name']}"
      @stream.puts " Monsters: #{encounter['monsters']}"
      @stream.puts " XP: #{encounter['xp']}"
      @stream.puts " Treasure: #{encounter['treasure']}" unless encounter['treasure'].empty?
      @stream.puts " Items: #{encounter['items']}" unless encounter['items'].empty?
    end
  end
end
