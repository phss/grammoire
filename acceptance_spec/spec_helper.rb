require 'rspec'
require 'mocha'
require File.expand_path(File.dirname(__FILE__) + "/../lib/grammoire")
include Grammoire

class StubRandomGenerator < RandomGenerator
  
  def returning_results(*results)
    @results = results
    return self
  end

  def self.should_produce(*results)
    StubRandomGenerator.new.returning_results(*results)
  end

  def number_up_to(max)
    @results.shift
  end
end