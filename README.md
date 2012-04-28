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

Multiple rules for same symbol

Rule weights

Rule pre conditions

Data points

Custom contexts