require 'spec_helper'

describe Grammar do
  let(:grammar) { Grammar.new }

  it 'evaluates existing rule' do
    pending
    
    rules = mock()
    rule = mock()
    context = mock()

    rules.expects(:for).with(:some_rule).returns(rule)
    rule.expects(:evaluate).with(context).returns(:expected_output)

    grammar.evaluate(:some_rule).should == :expected_output
  end

  # TODO: replace the acceptance tests below by something more appropriate
  # for the unit level

  describe '(producing)' do
    it 'should evaluate terminal symbol of a rule' do
      grammar.rule(:terminal) { produce { 'terminal' } }

      grammar.evaluate(:terminal).should == 'terminal'
    end

    it 'should select one of the production rules' do
      random_generator = StubRandomGenerator.should_produce(0, 1, 1)
      grammar = Grammar.new(random_generator)

      grammar.rule(:two_choices) { produce { 'terminal x' } }
      grammar.rule(:two_choices) { produce { 'terminal y' } }

      grammar.evaluate(:two_choices).should == 'terminal x'
      grammar.evaluate(:two_choices).should == 'terminal y'
      grammar.evaluate(:two_choices).should == 'terminal y'
    end

    it 'should evaluate rules that pass the pre condition check' do
      grammar.rule(:condition) { pre_condition { false }; produce { 'not running' } }
      grammar.rule(:condition) { pre_condition { true }; produce { 'I am true!' } }
      grammar.rule(:condition) { pre_condition { false }; produce { 'I am false' }; weights 1000 }

      grammar.evaluate(:condition).should == 'I am true!'  
    end
    
  end

  describe '(data points)' do
    it 'should evaluate with data points' do
      grammar.rule(:with_data) { produce { data(:some_data) } }

      grammar.evaluate(:with_data, :some_data => 123).should == 123
    end
  end

  describe '(context)' do
    it 'should define custom context for productions to be executed' do
      class CustomContext < EvaluationContext
        def custom_method
          "hello there"
        end
      end

      grammar.context(CustomContext)
      grammar.rule(:custom) { produce { custom_method } }

      grammar.evaluate(:custom).should == "hello there"
    end
  end

  describe '(validation)' do
    it 'should raise an exception when trying to evaluate output for non existent rule' do
      lambda { grammar.evaluate(:no_such_rule) }.should raise_error(GrammarError, "Rule 'no_such_rule' doesn't exist in the grammar or don't have valid pre-conditions.")
    end

    it 'should raise an exception when evaluating a rule without valid productions' do
      grammar.rule(:invalid) { pre_condition { false }; produce { 'not valid' } }

      lambda { grammar.evaluate(:invalid) }.should raise_error(GrammarError, "Rule 'invalid' doesn't exist in the grammar or don't have valid pre-conditions.")
    end
  end

end