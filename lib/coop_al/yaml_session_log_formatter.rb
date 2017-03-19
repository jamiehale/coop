require 'yaml'

module CoopAl
  ##
  # YamlSessionLogFormater
  #
  class YamlSessionLogFormatter
    def initialize(stream)
      @stream = stream
    end

    def write(log)
      obj = SessionLogConverter.new.to_obj(log)
      @stream.write(obj.to_yaml(options = {:line_width => -1}))
    end
  end
end
