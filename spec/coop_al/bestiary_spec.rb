require 'spec_helper'

module CoopAl
  describe Bestiary do
    it 'is initially empty' do
      expect(Bestiary.clone.instance).to be_empty
    end

    it 'does not have monster' do
      expect(Bestiary.clone.instance.monster?(:monster)).to be false
    end

    describe 'add' do
      let(:bestiary) { Bestiary.clone.instance }
      let(:monster) { double('monster', id: :monster) }

      before(:each) do
        bestiary.add(monster)
      end

      it 'has the monster' do
        expect(bestiary.monster?(:monster)).to be true
      end
    end
  end
end
