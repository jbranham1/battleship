class PlacementValidation
  def consecutive?(coordinates)
    if letters(coordinates).all?(coordinates[0][0])
      numbers(coordinates).size == coordinates.size
    elsif numbers(coordinates).count == 1
      letters(coordinates).size == coordinates.size
    else
      false
    end
  end

  def letters(coordinates)
    [*(letters_sort(coordinates)[0]..letters_sort(coordinates)[-1])]
  end

  def letters_sort(coordinates)
    coordinates.map do |coordinate|
      coordinate[0]
    end.uniq.sort
  end

  def numbers(coordinates)
    [*(numb_sort(coordinates)[0]..numb_sort(coordinates)[-1])]
  end

  def numb_sort(coordinates)
    nums = coordinates.map do |coordinate|
      coordinate[1..-1].to_i
    end
    nums.sort.map {|num| num.to_s}
  end
end
