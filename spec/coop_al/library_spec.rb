require 'spec_helper'

module CoopAl
  describe Library do
    it 'is a singleton' do
      expect(Library.instance).to eq(Library.instance)
    end

    describe 'once created' do
      let(:library) { Library.clone.instance }

      it 'is empty' do
        expect(library).to be_empty
      end

      describe 'adding adventures' do
        let(:adventure1) { Adventure.new(:adventure1, 'Adventure 1') }

        before(:each) do
          library.add_adventure(adventure1)
        end

        it 'is no longer empty' do
          expect(library).not_to be_empty
        end

        it 'can find adventures by name' do
          expect(library.adventure(:adventure1)).to eq(adventure1)
        end

        it 'throws if you try to add the same adventure twice' do
          expect { library.add_adventure(adventure1) }.to raise_error(Exception)
        end
      end
    end
  end
end
