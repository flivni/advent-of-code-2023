# Advent 2023, Day 11

In order to account for part2, I reimplemented to use something
more space efficient for the galaxy expansion.

When implementing part1, I decided to read the file into a 2d-array and then
expand the universe into another 2d-array. My reasoning for this approach
was that it could be printed out and visually verified.

In part2, the universe expands far bigger and so I moved to representing
the expanded universe as the original 2d-universe plus a row and col vector
that tracked the amount of "accumulated" expansion in each direction. 
Ironically, this was my first thought when I read the problem, and I think
the implementation is simpler than my part1 solution. 

### Other ideas / potential improvements
~~If the starting universe was very large, it might be nice to not read the
whole universe into a 2d-array. Instead, one could scan through the file
and (1) build up the row and col accumulation vectors and (2) build the
galaxy list. This again, ironically, makes the code simpler. But similarly,
makes it a bit harder to debug. Thinking about it, I might just do this as
a second pass.~~
