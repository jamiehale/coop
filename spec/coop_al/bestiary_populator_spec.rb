require 'spec_helper'

module CoopAl
  describe BestiaryPopulator do
    it 'does nothing when passed an empty block' do
      BestiaryPopulator.new {}
      expect(Bestiary.instance).to be_empty
    end

    describe 'add' do
      let(:id) { double(:id) }
      let(:cr) { double(:cr) }
      let(:treasure) { double(:treasure) }

      describe 'with no treasure' do
        before(:each) do
          BestiaryPopulator.new do
            add(:id, :cr2)
          end
        end

        it 'has a monster definition' do
          expect(Bestiary.instance.monster?(:id)).to be true
        end

        it 'has the correct monster definition' do
          expect(Bestiary.instance.monster(:id)).to eq(MonsterDefinition.new(:id, :cr2, :individual))
        end
      end

      describe 'with treasure' do
        before(:each) do
          BestiaryPopulator.new do
            add(:id2, :cr3, :hoard)
          end
        end

        it 'has a monster definition' do
          expect(Bestiary.instance.monster?(:id2)).to be true
        end

        it 'has the correct monster definition' do
          expect(Bestiary.instance.monster(:id2)).to eq(MonsterDefinition.new(:id2, :cr3, :hoard))
        end
      end
    end
  end
end
