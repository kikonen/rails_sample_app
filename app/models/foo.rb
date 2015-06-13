class Foo
  def self.test_to_json
    test {|data| data.to_json }
  end

  def self.test_multi_json
    test {|data| MultiJson.dump(data) }
  end

  def self.test_oj
    test {|data| Oj.dump(data) }
  end

  def self.test
    data = {}
    key = 'aaa'
    1000.times { data[key.succ!] = data.keys }
    r = Benchmark.realtime do
      10.times do |i|
        puts i
        yield(data)
      end
    end
    r / 10.to_f
  end
end
