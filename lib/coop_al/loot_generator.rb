module CoopAl
  ##
  # LootGenerator
  #
  class LootGenerator
    def initialize
    end

    def generate(cr, treasure)
      return Loot.empty if treasure == :no_treasure
      return generate_individual(cr) if treasure == :individual
      generate_hoard(cr)
    end

    private

    def generate_individual(cr)
      table_name = individual_treasure_table_by_cr(cr)
      treasure = Treasure.new(roll_on(table_name))
      Loot.from_treasure(treasure)
    end

    def individual_treasure_table_by_cr(cr)
      value = cr_value(cr)
      return :individual_treasure_cr_0_4 if value <= 4
      return :individual_treasure_cr_5_10 if value <= 10
      return :individual_treasure_cr_11_16 if value <= 16
      :individual_treasure_cr_17_
    end

    def cr_value(cr)
      return 0.125 if cr == :cr1_8
      return 0.25 if cr == :cr1_4
      return 0.5 if cr == :cr1_2
      cr[2..-1].to_i
    end

    def generate_hoard(_cr)
      raise 'Hoard loot not implemented'
    end
  end
end
