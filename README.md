Grammoire
=========

A context-sensitive grammar library for producing randomised objects.

A more usual use of a grammar is to parse strings into objects and other programming language constructs, to be 
interpreted. Instead of this, Grammoire allows you to define a grammar for producing objects in randomised ways. 

It was inspired by http://www.contextfreeart.org/. 

An example of a grammar for generating well-formed parentheses 
(http://en.wikipedia.org/wiki/Context_free_grammar#Well-formed_parentheses ):

    grammar = Grammoire.define do
      rule(:s) { produce { eval(:s) + eval(:s) } }
      rule(:s) { produce { '(' + eval(:s) + ')' } }
      rule(:s) { produce { '()' } }
    end
    
    grammar.evaluate(:s) # possible result => ()((())(()))(((())))(((())))
    
Installation
------------
    gem install grammoire
    
Features
--------

_Multiple rules for same symbol_

    grammar = Grammoire.define do
      rule(:terminal) { produce { 'a' } }
      rule(:terminal) { produce { 'b' } }
    end
    
    grammar.evaluate(:terminal) # Equal chances of generating an 'a' or 'b'

_Rule weights_

    grammar = Grammoire.define do
      rule(:weighted) { weights 4; produce { 'a' } }
      rule(:weighted) { weights 2; produce { 'b' } }
    end
    
    grammar.evaluate(:weighted) # Twice more likely of generating 'a' rather then 'b'

_Data points_

    grammar = Grammoire.define do
      rule(:full_name) { produce { eval(:first_name) + ' ' + eval(:last_name) } }
      rule(:first_name) { produce { data(:first) } }
      rule(:last_name) { produce { data(:last) } }
    end
    
    grammar.evaluate(:full_name, :first => "Jonny", :last => "Data") # => Produces 'Jonny Data'

_Rule pre-conditions_

    grammar = Grammoire.define do
      rule(:conditionals) do
        pre_condition { data(:number) >= 5 }
        produce { 'More then 5!' }
      end
      rule(:conditionals) do
        pre_condition { data(:number) < 5 }
        produce { 'Less then 5.' }
      end      
    end
    
    grammar.evaluate(:conditionals, :number => 7) # => Produces 'More then 5!'