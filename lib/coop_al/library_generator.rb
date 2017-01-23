def adventure(name, description = nil, &blk)
  generator = CoopAl::AdventureGenerator.new(name, description, CoopAl::Bestiary.instance)
  generator.instance_eval(&blk)
end
