require 'spec_helper'

describe ProductionChooser do
  let(:generator) { StubRandomGenerator.new }
  let(:chooser) { ProductionChooser.new(generator) }

  it 'should return nil if no production is given' do
    chooser.select_from([]).should be_nil
  end

  it 'should select only production if only one production is given' do
    generator.returning_results(0, 1)

    production = Production.new(1)

    chooser.select_from([production]).should == production
  end

  it 'should select production based on the probability over the weightings' do
    generator.returning_results(0, 1, 2, 3)

    heavier_production = Production.new(3)
    lighter_production = Production.new(1)
    productions = [heavier_production, lighter_production]
    
    chooser.select_from(productions).should == heavier_production
    chooser.select_from(productions).should == heavier_production
    chooser.select_from(productions).should == heavier_production
    chooser.select_from(productions).should == lighter_production
  end

end