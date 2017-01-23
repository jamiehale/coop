require 'spec_helper'

module CoopAl
  describe MonsterDefinition do
    let(:id) { double(:id) }
    let(:cr) { double(:cr) }
    let(:treasure) { double(:treasure) }
    let(:monster) { MonsterDefinition.new(id, cr, treasure) }

    it 'knows its id' do
      expect(monster.id).to eq(id)
    end

    it 'knows its cr' do
      expect(monster.cr).to eq(cr)
    end

    it 'knows its treasure' do
      expect(monster.treasure).to eq(treasure)
    end

    it 'knows equality' do
      expect(MonsterDefinition.new(:id, :cr2, :hoard)).to eq(MonsterDefinition.new(:id, :cr2, :hoard))
    end
  end
end
