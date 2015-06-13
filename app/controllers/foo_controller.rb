class FooController < ApplicationController
  def show_to_json
    puts "show_to_json"
    render json: FooController.data
  end

  def show_multi_json
    puts "show_multi_json"
    render json: MultiJson.dump(FooController.data)
  end

  def show_oj
    puts "show_oj"
    render json: Oj.dump(FooController.data)
  end


  @@data = nil
  def self.data
    data = @@data
    unless data
      data = {}
      key = 'aaa'
      1000.times { data[key.succ!] = data.keys }
      @data = data
    end
    data
  end
end
