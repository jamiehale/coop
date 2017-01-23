adventure :test, 'Simple Adventure' do
  entry :chapter_1
  chapter :chapter_1, 'Chapter 1' do
    encounter '1. Entrance' do
      monster :goblin
      monsters 2, :orc
      treasure '2d6*10'.gp
      item 'Potion of healing'
    end
    link_to :chapter_2
    link_to_downtime
  end
  chapter :chapter_2, 'Chapter 2' do
  end
end
