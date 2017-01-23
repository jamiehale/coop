module CoopAl
  ##
  # XpRewardTable
  #
  class XpRewardTable
    def initialize
      @xp_by_cr = {
        cr0: 10,
        cr1_8: 25,
        cr1_4: 50,
        cr1_2: 100,
        cr1: 200,
        cr2: 450,
        cr3: 700,
        cr4: 1_100,
        cr5: 1_800,
        cr6: 2_300,
        cr7: 2_900,
        cr8: 3_900,
        cr9: 5_000,
        cr10: 5_900,
        cr11: 7_200,
        cr12: 8_400,
        cr13: 10_000,
        cr14: 11_500,
        cr15: 13_000,
        cr16: 15_000,
        cr17: 18_000,
        cr18: 20_000,
        cr19: 22_000,
        cr20: 25_000,
        cr21: 33_000,
        cr22: 41_000,
        cr23: 50_000,
        cr24: 62_000,
        cr25: 75_000,
        cr26: 90_000,
        cr27: 105_000,
        cr28: 120_000,
        cr29: 135_000,
        cr30: 155_000
      }
    end

    def [](cr)
      @xp_by_cr[cr]
    end
  end

  ##
  # XpRequirementTable
  #
  class XpRequirementTable
    def initialize
      @xp_by_level = {
        1 => 0,
        2 => 300,
        3 => 900,
        4 => 2_700,
        5 => 6_500,
        6 => 14_000,
        7 => 23_000,
        8 => 34_000,
        9 => 48_000,
        10 => 64_000,
        11 => 85_000,
        12 => 100_000,
        13 => 120_000,
        14 => 140_000,
        15 => 165_000,
        16 => 195_000,
        17 => 225_000,
        18 => 265_000,
        19 => 305_000,
        20 => 355_000
      }
    end

    def level_from_xp(xp)
      20.downto(1) do |i|
        return i if xp >= @xp_by_level[i]
      end
      raise 'Invalid xp value (#{xp})'
    end
  end
end
