table :individual_treasure_cr_0_4 do
  f(1..30) { '5d6'.cp }
  f(31..60) { '4d6'.sp }
  f(61..70) { '3d6'.ep }
  f(71..95) { '3d6'.gp }
  f(96..100) { '1d6'.pp }
end

table :individual_treasure_cr_5_10 do
  f(1..30) { '4d6*100'.cp + '1d6*10'.ep }
  f(31..60) { '6d6*10'.sp + '2d6*10'.gp }
  f(61..70) { '3d6*10'.ep + '2d6*10'.gp }
  f(71..95) { '4d6*10'.gp }
  f(96..100) { '2d6*10'.gp + '3d6'.pp }
end

table :individual_treasure_cr_11_16 do
  f(1..20) { '4d6*100'.sp + '1d6*100'.gp }
  f(21..35) { '1d6*100'.ep + '1d6*100'.gp }
  f(36..75) { '2d6*100'.gp + '1d6*10'.pp }
  f(76..100) { '2d6*100'.gp + '2d6*10'.pp }
end

table :individual_treasure_cr_17_ do
  f(1..15) { '2d6*1000'.ep + '8d6*100'.gp }
  f(16..55) { '1d6*1000'.gp + '1d6*100'.pp }
  f(56..100) { '1d6*1000'.gp + '2d6*100'.pp }
end
