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

## Rough ideas on potential improvements
~~If the starting universe was very large, it might be nice to not read the
whole universe into a 2d-array. Instead, one could scan through the file
and (1) build up the row and col accumulation vectors and (2) build the
galaxy list. This again, ironically, makes the code simpler. But similarly,
makes it a bit harder to debug. Thinking about it, I might just do this as
a second pass.~~

I ended up implementing this.

### Using sparse arrays to represent the accumulation vectors to get the space complexity down to O(galaxies).

Observation: The number of rows that don't expand is guaranteed <= the number
of galaxies. Same with cols. 

The vectors I call accumulation vectors in part 2 can be compressed.
These row/col vectors indicate the cumulative number expansions
traveling top to bottom and left to right. So, a column vector might look like this:
[0, 0, 1, 1, 1, 2, 2] which represents that when you are at column 6 or 7, the universe
has expanded in two places to the left. If the universe is sparse, most columns
will indicate expansion, so you will see long runs of numbers like:
[1, 2, 3, 4, 5, 6, ... , 100, 100, 101, 102, ...]
Here every column has undergone expansion except for column 101 which contains at least
one galaxy.

This vector can be compressed such that use a sparse array and only store the columns
that **don't** expand, and we will have runs of increasing numbers between.
