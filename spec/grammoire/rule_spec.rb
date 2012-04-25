require 'spec_helper'

describe Rule do
  let(:rule) { Rule.new }

  it 'should return list of productions' do
    first_production = Production.new
    second_production = Production.new
    third_production = Production.new

    rule << first_production
    rule << second_production
    rule << third_production

    rule.productions.should =~ [ first_production, second_production, third_production ]
  end

end