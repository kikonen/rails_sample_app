require 'spec_helper'

describe FooController do
  def run_test
    r = Benchmark.realtime do
      10.times do |i|
        puts i
        yield
      end
    end
    r / 10.to_f
  end

  it 'test_json' do
    r = run_test do
      get :show_to_json
    end
    puts "to_json: #{r}"
  end

  it 'test_multi_json' do
    r = run_test do
      get :show_multi_json
    end
    puts "multi_json: #{r}"
  end

  it 'test_oj' do
    r = run_test do
      get :show_oj
    end
    puts "oj: #{r}"
  end

end
