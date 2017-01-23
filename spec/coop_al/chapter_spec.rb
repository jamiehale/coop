require 'spec_helper'

module CoopAl
  describe Chapter do
    describe 'once created' do
      let(:name) { :name }
      let(:description) { 'description' }
      let(:adventure) { double(:adventure, full_name: 'Adventure') }
      let(:chapter) { Chapter.new(name, description, adventure) }

      it 'knows its name' do
        expect(chapter.name).to eq(name)
      end

      it 'knows its description' do
        expect(chapter.description).to eq(description)
      end

      it 'knows its full name' do
        expect(chapter.full_name).to eq(adventure.full_name + ' - ' + description)
      end

      it 'has no encounters' do
        expect(chapter.encounters).to be_empty
      end

      it 'has no links' do
        expect(chapter.links).to be_empty
      end

      it 'does not link to downtime' do
        expect(chapter.links_to_downtime?).to be false
      end
    end
  end
end
