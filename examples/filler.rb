adventure :filler, 'Filler' do
  entry :chapter_1
  chapter :chapter_1, 'Chapter 1. Filler' do
    encounter 'Bag of XP' do
      xp 4000 * 6
    end
    link_to_downtime
  end
end
