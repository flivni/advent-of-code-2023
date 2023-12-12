require 'minitest/autorun'
require_relative 'part2'

module Dec11
class Part2Test < Minitest::Test
  def test_distances
    dec11 = Dec11::Part2.new(is_test: true)
    assert_equal 9, dec11.distance(dec11.galaxies[4], dec11.galaxies[8])
    assert_equal 15, dec11.distance(dec11.galaxies[0], dec11.galaxies[6])
    assert_equal 17, dec11.distance(dec11.galaxies[2], dec11.galaxies[5])
    assert_equal 5, dec11.distance(dec11.galaxies[7], dec11.galaxies[8])

    assert_equal 374, dec11.sum_pairwise_distances
  end

  def test_assert_v1_answer
    dec11 = Dec11::Part2.new
    assert_equal 9565386, dec11.sum_pairwise_distances
  end

  def test_assert_puzzle_description_answers
    dec11 = Dec11::Part2.new(is_test: true, age_multiplyer: 10)
    assert_equal 1030, dec11.sum_pairwise_distances

    dec11 = Dec11::Part2.new(is_test: true, age_multiplyer: 100)
    assert_equal 8410, dec11.sum_pairwise_distances
  end

  def test_print_part2_answer
    dec11 = Dec11::Part2.new(age_multiplyer: 1_000_000)
    puts "Part 2 answer: #{dec11.sum_pairwise_distances}"
  end
end
end