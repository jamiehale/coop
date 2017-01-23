module CoopAl
  ##
  # Loot
  #
  class Loot
    attr_reader :treasures, :items

    def initialize(treasures, items)
      @treasures = treasures
      @items = items
    end

    def empty?
      return false unless @treasures.empty?
      return false unless @items.empty?
      true
    end

    def add_treasure(treasure)
      @treasures << treasure
    end

    def add_item(item)
      @items << item
    end

    def +(other)
      @treasures += other.treasures
      @items += other.items
      self
    end

    def treasure_value
      @treasures.inject(Value.new) { |a, e| a + e.value }
    end

    def self.empty
      Loot.new([], [])
    end

    def self.from_treasure(treasure)
      Loot.new([treasure], [])
    end

    def self.from_item(item)
      Loot.new([], [item])
    end
  end
end
