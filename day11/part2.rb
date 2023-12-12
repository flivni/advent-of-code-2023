module Dec11
class Part2
  attr_reader :is_test, :data, :age_multiplyer, :galaxies, :acc_expand_cols, :acc_expand_rows
  def initialize(is_test: false, age_multiplyer: 2)
    @is_test, @age_multiplyer = is_test, age_multiplyer
    @data = File.readlines(is_test ? 'dec11/test_data.txt' : 'dec11/data.txt').map { |line| line.chomp.chars }
  end

  def age_galaxy
    # as a first step, I create two vectors, each indicates which rows/columns will expand.
    expand_rows = Array.new(@data.length, true)
    expand_cols = Array.new(@data.length, true)
    @data.each_with_index do |row, i|
      row.each_with_index do |col, j|
        if col == '#'
          expand_rows[i] = false
          expand_cols[j] = false
        end
      end
    end

    # as a second step, I'll maintain row/col vectors that indicate the cumulative number expansions
    # traveling left to right and top to bottom.
    @acc_expand_rows = acc_expand_vector(expand_rows)
    @acc_expand_cols = acc_expand_vector(expand_cols)
  end

  def acc_expand_vector(expand_vector)
    ret_vector = Array.new(expand_vector.length)
    acc = 0
    expand_vector.each_with_index do |v, i|
      acc += 1 if v
      ret_vector[i] = acc
    end
    ret_vector
  end

  def init_galaxies
    @galaxies = []
    @data.each_with_index do |row, y|
      row.each_with_index do |cell, x|
        next if cell == '.'
        @galaxies << {
          x: x + (acc_expand_cols[x] * (age_multiplyer - 1)),
          y: y + (acc_expand_rows[y] * (age_multiplyer - 1))
        }
      end
    end
  end

  def distance(g1, g2)
    (g1[:x] - g2[:x]).abs + (g1[:y] - g2[:y]).abs
  end

  def sum_pairwise_distances
    sum = 0
    (0...@galaxies.length).each do |i|
      (i+1...@galaxies.length).each do |j|
        sum += distance(@galaxies[i], @galaxies[j])
      end
    end
    sum
  end
end

end