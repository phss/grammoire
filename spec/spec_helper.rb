require 'rspec'
require File.expand_path(File.dirname(__FILE__) + "/../lib/grammoire")

class StubRandomGenerator
  def initialize(results)
    @results = results
  end

  def self.should_produce(*results)
    StubRandomGenerator.new(results)
  end

  def next(upto)
    @results.shift
  end
end