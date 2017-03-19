module CoopAl
  ##
  # Value
  #
  class Value
    attr_reader :platinum, :electrum, :gold, :silver, :copper

    def initialize(amounts = {})
      @platinum = amounts[:platinum] || 0
      @electrum = amounts[:electrum] || 0
      @gold = amounts[:gold] || 0
      @silver = amounts[:silver] || 0
      @copper = amounts[:copper] || 0
      normalize
    end

    alias pp platinum
    alias ep electrum
    alias gp gold
    alias sp silver
    alias cp copper

    def zero?
      raw_value.zero?
    end

    def nonzero?
      !zero?
    end

    def raw_value
      @platinum * 10 + @gold + @silver / 10.0 + @copper / 100.0 + @electrum / 2.0
    end

    def normalize_from(value)
      @platinum = 0
      @electrum = 0
      @gold = value.floor
      value -= @gold
      value *= 10
      @silver = value.floor
      value -= @silver
      value *= 10
      @copper = value.floor
    end

    def normalize
      normalize_from(raw_value)
    end

    def +(other)
      @platinum += other.pp
      @electrum += other.ep
      @gold += other.gp
      @silver += other.sp
      @copper += other.cp
      normalize
      self
    end

    def *(other)
      normalize_from(raw_value * other)
      self
    end

    def /(other)
      normalize_from(raw_value / other)
      self
    end

    def self.platinum(amount)
      Value.new(platinum: amount)
    end

    def self.gold(amount)
      Value.new(gold: amount)
    end

    def self.silver(amount)
      Value.new(silver: amount)
    end

    def self.copper(amount)
      Value.new(copper: amount)
    end

    def self.electrum(amount)
      Value.new(electrum: amount)
    end

    def to_a
      [@platinum, @electrum, @gold, @silver, @copper]
    end

    def to_s
      [
        [@platinum, 'pp'],
        [@gold, 'gp'],
        [@silver, 'sp'],
        [@copper, 'cp'],
        [@electrum, 'ep']
      ].select { |v| v[0].nonzero? }.map { |v| "#{v[0]}#{v[1]}" }.join(', ')
    end
  end
end

##
# Integer monkey-patch
#
class Integer
  def platinum
    CoopAl::Value.platinum(to_i)
  end

  def gold
    CoopAl::Value.gold(to_i)
  end

  def silver
    CoopAl::Value.silver(to_i)
  end

  def copper
    CoopAl::Value.copper(to_i)
  end

  def electrum
    CoopAl::Value.electrum(to_i)
  end

  alias gp gold
  alias sp silver
  alias cp copper
  alias pp platinum
  alias ep electrum
end

##
# String monkey-patch
#
class String
  def platinum
    CoopAl::Value.platinum(roll)
  end

  def gold
    CoopAl::Value.gold(roll)
  end

  def silver
    CoopAl::Value.silver(roll)
  end

  def copper
    CoopAl::Value.copper(roll)
  end

  def electrum
    CoopAl::Value.electrum(roll)
  end

  alias gp gold
  alias sp silver
  alias cp copper
  alias pp platinum
  alias ep electrum
end
