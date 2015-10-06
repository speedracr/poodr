module FakeEnumerable
  def map
    out = []
    each { |e| out << yield(e) }
  end

  def select
    [].tap { |out| each { |e| out << e if yield(e) } }
  end

  def sort_by
    map { |a| [yield(a), a] }.sort.map { |a| a[1] }
  end

  def reduce(*args)

  end
end

module FakeEnumerator

end
