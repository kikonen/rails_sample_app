
class Test

  def self.test
    data = {}
    key = 'aaa'
    1000.times { data[key.succ!] = data.keys }
  1000 * Benchmark.realtime { data.to_json }
  end
end
