require 'spec_helper'

module CoopAl
  describe Monster do
    let(:id) { double(:id) }
    let(:xp) { double(:xp) }
    let(:loot) { double(:loot) }
    let(:encounter) { double(:encounter) }
    let(:monster) { Monster.new(id, xp, loot, encounter) }

    it 'knows its id' do
      expect(monster.id).to eq(id)
    end

    it 'knows its xp' do
      expect(monster.xp).to eq(xp)
    end

    it 'knows its loot' do
      expect(monster.loot).to eq(loot)
    end

    it 'knows its encounter' do
      expect(monster.encounter).to eq(encounter)
    end
  end
end
