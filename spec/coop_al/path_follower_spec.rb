require 'spec_helper'

module CoopAl
  describe PathFollower do
    describe 'once created' do
      let(:library) { double(:library) }
      let(:initial_state) { State.new }
      let(:follower) { PathFollower.new(library, initial_state) }

      it 'knows its initial state' do
        expect(follower.state).to eq(initial_state)
      end

      describe 'following paths' do
        describe 'empty path set' do
          let(:paths) { [] }

          before(:each) do
            follower.follow(paths)
          end

          it 'makes no changes when following no paths' do
            expect(follower.state).to eq(initial_state)
          end
        end

        describe 'a single path that doesn\'t exist' do
          let(:path) { Path.new(:no_adventure, :no_chapter) }
          let(:paths) { [path] }

          before(:each) do
            allow(library).to receive(:path?).and_return(false)
          end

          it 'throws' do
            expect { follower.follow(paths) }.to raise_error(Exception)
          end
        end

        describe 'a single path that exists' do
          let(:chapter) { double(:chapter) }
          let(:path) { Path.new(:adventure, :chapter) }
          let(:paths) { [path] }

          before(:each) do
            allow(library).to receive(:path?).and_return(true)
            allow(library).to receive(:resolve).and_return(chapter)
            allow(chapter).to receive(:follow)
          end

          it 'defers to the chapter at the path' do
            follower.follow(paths)
            expect(chapter).to have_received(:follow).with(initial_state)
          end

          it 'applies the new path' do
            follower.follow(paths)
            expect(initial_state.current_path).to eq(path)
          end
        end

        describe 'multiple paths where one doesn\'t exist' do
        end

        describe 'multiple paths where all exist' do
        end
      end
    end
  end
end
