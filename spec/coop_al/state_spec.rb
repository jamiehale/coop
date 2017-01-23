require 'spec_helper'

module CoopAl
  describe State do
    describe 'once created' do
      let(:state) { State.new }

      it 'has no xp' do
        expect(state.xp).to eq(0)
      end

      it 'has no current path' do
        expect(state.current_path).to eq(Path.root)
      end

      it 'is in downtime' do
        expect(state).to be_in_downtime
      end

      describe 'available paths' do
        let(:path1) { double(:path1) }
        let(:path2) { double(:path2) }
        let(:library) { double(:library, all_entries: [path1, path2]) }

        it 'knows available paths are all library entries' do
          paths = state.available_paths(library)
          expect(paths.size).to eq(2)
          expect(paths).to include(path1)
          expect(paths).to include(path2)
        end
      end

      describe 'applying paths' do
        let(:root) { Path.root }
        let(:absolute) { Path.absolute(:adventure, :chapter_1) }
        let(:relative) { Path.relative(:chapter_2) }

        it 'sets root paths' do
          state.apply_path(root)
          expect(state.current_path).to be_root
        end

        it 'sets absolute paths' do
          state.apply_path(absolute)
          expect(state.current_path).to eq(absolute)
        end

        it 'sets relative paths' do
          state.apply_path(absolute)
          state.apply_path(relative)
          expect(state.current_path).to eq(Path.absolute(:adventure, :chapter_2))
        end
      end
    end
  end
end
