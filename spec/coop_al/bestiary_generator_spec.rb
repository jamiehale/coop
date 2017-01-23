require 'spec_helper'

module CoopAl
  describe 'Bestiary generator' do
    it 'leaves the bestiary alone' do
      bestiary do
      end
      expect(Bestiary.instance).to be_empty
    end
  end
end
