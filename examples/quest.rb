adventure :quest, 'Quest For Inclusion' do
  entry :chapter_1
  chapter :chapter_1, 'Chapter 1. Surrounding Area' do
    10.times do
      random 'Random Encounters' do
        f(1..10) {}
        f(11..15) { monsters 'd4', :goblin }
        f(16..18) { monster :bugbear }
        f(19..20) { monsters 'd6', :wolf }
      end
    end
    encounter '1. Patrol' do
      monster :goblin
      monsters 2, :orc
      treasure '2d6*10'.gp
      item 'Potion of healing'
    end
    encounter '2. Old Man Wasisname' do
      npc :cr0
      item 'Vorpal sword'
      treasure 1000.gp, 'diamond'
      treasure 5000.gp
    end
    link_to :chapter_2
    link_to_downtime
  end
  chapter :chapter_2, 'Chapter 2. The Caves' do
    10.times do
      random 'Random Encounters' do
        f(1..10) {}
        f(11..16) { monsters 'd3', :orc }
        f(17..19) do
          monster :bugbear
          monsters 'd4', :goblin
        end
      end
    end
    encounter 'Ground Floor' do
      encounter '1. Entry' do
        monsters 2, :wolf
      end
      encounter '2. Barracks' do
        monsters 5, :goblin
        treasure '2d6'.gp
        item 'Potion of healing'
      end
    end
    encounter 'Basement' do
      encounter '3. Oops' do
        monster :balor
      end
      encounter '4. Princess!' do
        xp 1000
      end
    end
    link_to_downtime
  end
end
