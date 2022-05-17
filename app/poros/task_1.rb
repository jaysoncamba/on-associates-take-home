class Task1

  # When passed two arrays of names, it will return an array containing the names
  # that appear in either or both arrays. The returned array should have no duplicates.

  def unique_names(names1, names2)
    return unless [names1, names2].all? {|names| names.is_a?(Array) }
    [names1, names2].flatten.uniq
  end

  # should print array of Ava, Emma, Olivia, Sophia in any order
  def test_1
    names1 = ["Ava", "Emma", "Olivia"]
    names2 = ["Olivia", "Sophia", "Emma"]
    puts unique_names(names1, names2)
  end

  # should print array of Ava, Emma, Olivia, Sophia in any order
  def test_2
    names1 = ["Ava", ["Olivia", "Emma"]]
    names2 = ["Sophia", "Emma"]
    puts unique_names(names1, names2)
  end

end