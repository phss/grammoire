class RandomGenerator
  def number_up_to(max)
    rand(max)
  end

  def one_of(options)
    options[number_up_to(options.size)]
  end
end