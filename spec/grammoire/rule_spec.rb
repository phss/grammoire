require 'spec_helper'

describe Rule do
  let(:rule) { Rule.new }

  it 'should select only production' do
    random_generator = StubRandomGenerator.should_produce(0)
    only_production = Production.new
    rule << only_production

    rule.select_production(random_generator).should == only_production
  end

  it 'should randomly select one of the production rules' do
    random_generator = StubRandomGenerator.should_produce(2, 0, 1)
    first_production = Production.new
    second_production = Production.new
    third_production = Production.new

    rule << first_production
    rule << second_production
    rule << third_production

    rule.select_production(random_generator).should == third_production
    rule.select_production(random_generator).should == first_production
    rule.select_production(random_generator).should == second_production
  end

end