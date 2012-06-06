require 'spec_helper'

describe 'Grammoire acceptance specs' do
  
  describe '(producing)' do
    it 'evaluates terminal symbol of a rule' do
      grammar = Grammoire.define do
        rule(:terminal) { produce { 'terminal' } }
      end

      grammar.evaluate(:terminal).should == 'terminal'
    end

    it 'evaluate and substitute symbols when producing a non-terminal rule' do
      grammar = Grammoire.define do
        rule(:non_terminal) { produce { 'non-' + eval(:terminal) } }
        rule(:terminal) { produce { 'terminal' } }  
      end

      grammar.evaluate(:non_terminal).should == 'non-terminal'
    end

    it 'select between two valid production rules' do
      # TODO: replace this with a mock?
      random_generator = StubRandomGenerator.should_produce(0, 1, 1)
      old_grammar = Grammar.new(random_generator)

      old_grammar.rule(:two_choices) { produce { 'terminal x' } }
      old_grammar.rule(:two_choices) { produce { 'terminal y' } }

      old_grammar.evaluate(:two_choices).should == 'terminal x'
      old_grammar.evaluate(:two_choices).should == 'terminal y'
      old_grammar.evaluate(:two_choices).should == 'terminal y'
    end

    it 'evaluate rules that pass the pre condition check' do
      grammar = Grammoire.define do
        rule(:condition) { pre_condition { false }; produce { 'not running' } }
        rule(:condition) { pre_condition { true }; produce { 'I am true!' } }
        rule(:condition) { pre_condition { false }; produce { 'I am false' }; weights 1000 }  
      end

      grammar.evaluate(:condition).should == 'I am true!'  
    end
    
  end

  describe '(data points)' do
    it 'should evaluate with data points' do
      grammar = Grammoire.define do
        rule(:with_data) { produce { data(:some_data) } }
      end

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

      grammar = Grammoire.define do
        context CustomContext
        rule(:custom) { produce { custom_method } }  
      end

      grammar.evaluate(:custom).should == "hello there"
    end
  end

  describe '(validation)' do
    it 'should raise an exception when trying to evaluate output for non existent rule' do
      grammar = Grammoire.define { }
      lambda { grammar.evaluate(:no_such_rule) }.should raise_error(GrammarError, "Rule 'no_such_rule' doesn't exist.")
    end

    it 'should raise an exception when evaluating a rule without valid productions' do
      grammar = Grammoire.define do
        rule(:invalid) { pre_condition { false }; produce { 'not valid' } }
      end

      lambda { grammar.evaluate(:invalid) }.should raise_error(GrammarError, "Rule 'invalid' doesn't exist in the grammar or don't have valid pre-conditions.")
    end
  end

end