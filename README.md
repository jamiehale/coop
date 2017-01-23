# Coop - Adventurers League Character Log Generator

> "Reality is frequently inaccurate." -- Douglas Adams

Coop is a little tool that uses simple DSL-specified Dungeons and Dragons adventures to generate a log of pretend gameplay to support an Adventurers League character.

It includes SRD content, but nothing else. You'll have to supply your own copy of WoTC material.

## Installation

    $> gem install coop_al

## Usage

    $> coop --help
    coop [options] resource [resource...]
    --path <path1>[,<path2>,...] Specify path to follow
    --path-file <filename>       Specify paths in a file, one per line
    --no-loot                    Do not report loot
    --no-xp                      Do not report accumulated XP
    --no-paths                   Do not report available paths
    --party-size n               Total XP and treasure is divided by n [6]
    --encounter-count n          Encounters per session [10]
    --end-date YYYY-MM-DD        Most recent session [today]
    --session-frequency n        Sessions every n days [7]
    --blackout-dates YYYY-MM-DD[,YYYY-MM-DD,...]
    --skip-frequency n           Chance of skipping week is 1 in n [never]
    --srd                        Use included SRD file for monsters
    --trace                      Print encounter details
    --help                       Print this help

## Customization

Check out the examples provided.

### Bestiary

Create your own bestiary by providing a resource file in the form:

    bestiary do
      add :scary_monster, :cr1_2
      add :scarier_monster, :cr17
    end

### Adventures

Create your own adventures by providing a resource file in the form:

    adventure :shortname, 'Adventure Name' do
      entry :chapter_1
      chapter :chapter_1, 'Chapter 1. Surrounding Area' do
        5.times do
          random 'Random Encounter' do
            f(1..2) { monster :scary_monster }
            f(3..20) { monsters '3d6', :scarier_monster }
          end
        end
        encounter 'Some old weak guy' do
          npc :cr0
          treasure 2000.gp + 400.pp
          treasure 1000.gp, 'diamond'
          item 'Vorpal sword'
        end
        encounter 'Bag of XP' do
          xp 500
        end
        link_to :chapter_2
      end
      chapter :chapter_2, 'Chapter 2. The Caves' do
        ...
        link_to_downtime
      end
    end

## Development

Coop is written in Ruby, and requires the [Tablescript gem](https://github.com/jamiehale/tablescript.rb).

### Tests

Such as they are...

    $> rake spec

Coverage provided by simplecov.

### Rubocop

    $> rake rubocop
