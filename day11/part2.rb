module Dec11
class Part2
  attr_reader :is_test, :data, :universe_expansion_factor, :galaxies, :acc_expand_cols, :acc_expand_rows
  def initialize(is_test: false, universe_expansion_factor: 2)
    @is_test, @universe_expansion_factor = is_test, universe_expansion_factor

    # expand_rows/expand_cols are vectors that indicate which rows/columns will expand.
    expand_rows = []
    expand_cols = []

    @galaxies = []

    File.foreach(data_filename).with_index do |line, y|
      line.chomp.chars.each_with_index do |v, x|
        expand_rows[y] = true if expand_rows[y].nil?
        expand_cols[x] = true if expand_cols[x].nil?
        if v == '#'
          @galaxies << { x: x, y: y }
          expand_rows[y] = false
          expand_cols[x] = false
        end
      end
    end

    # Maintain row/col vectors that indicate the cumulative number expansions
    # traveling left to right and top to bottom.
    @acc_expand_rows = acc_expand_vector(expand_rows)
    @acc_expand_cols = acc_expand_vector(expand_cols)
  end

  def data_filename
    is_test ? 'day11/test_data.txt' : 'day11/data.txt'
  end

  def acc_expand_vector(expand_vector)
    acc = 0
    expand_vector.map.with_index do |v, i|
      acc += 1 if v
      acc
    end
  end

  def distance(g1, g2)
    m = universe_expansion_factor - 1
    (g1[:x] - g2[:x] + m * (acc_expand_cols[g1[:x]] - acc_expand_cols[g2[:x]])).abs +
      (g1[:y] - g2[:y] + m * (acc_expand_rows[g1[:y]] - acc_expand_rows[g2[:y]])).abs
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