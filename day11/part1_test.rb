require 'minitest/autorun'
require_relative 'part1'

module Dec11
class Part1Test < Minitest::Test
  def test_read_data
    dec11 = Dec11::Part1.new(is_test: true)
    assert_equal '#', dec11.data[1][7]
    dec11.print
    dec11.expand_grid
    dec11.print

    expected_expanded_data = <<DATA
....#........
.........#...
#............
.............
.............
........#....
.#...........
............#
.............
.............
.........#...
#....#.......
DATA
    expected_data = expected_expanded_data.split("\n").map(&:chars)

    assert_equal expected_data, dec11.data
  end

  def test_distances
    dec11 = Dec11::Part1.new(is_test: true)
    dec11.expand_grid
    dec11.init_galaxies
    assert_equal 9, dec11.distance(dec11.galaxies[4], dec11.galaxies[8])
    assert_equal 15, dec11.distance(dec11.galaxies[0], dec11.galaxies[6])
    assert_equal 17, dec11.distance(dec11.galaxies[2], dec11.galaxies[5])
    assert_equal 5, dec11.distance(dec11.galaxies[7], dec11.galaxies[8])

    assert_equal 374, dec11.sum_pairwise_distances
  end

  def test_print_part1_answer
    dec11 = Dec11::Part1.new
    dec11.expand_grid
    dec11.init_galaxies

    puts "Part 1 answer: #{dec11.sum_pairwise_distances}"
  end
end
end