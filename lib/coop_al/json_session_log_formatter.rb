require 'json'

module CoopAl
  ##
  # JsonSessionLogFormatter
  #
  class JsonSessionLogFormatter
    def initialize(stream)
      @stream = stream
    end

    def write(log)
      obj = SessionLogConverter.new.to_obj(log)
      @stream.write(obj.to_json)
    end
  end
end
