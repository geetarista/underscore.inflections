root = exports ? @
_ = root._ or require 'underscore'

if typeof exports isnt "undefined"
  _.mixin require '../src/underscore.inflections'

defaultUncountables = [
  'equipment', 'information', 'rice', 'money', 'species', 'series',
  'fish', 'sheep', 'jeans', 'moose', 'deer', 'news'
]

singularToPlural =
  "search"      : "searches"
  "switch"      : "switches"
  "fix"         : "fixes"
  "box"         : "boxes"
  "process"     : "processes"
  "address"     : "addresses"
  "case"        : "cases"
  "stack"       : "stacks"
  "wish"        : "wishes"
  "fish"        : "fish"
  "jeans"       : "jeans"
  "funky jeans" : "funky jeans"
  "my money"    : "my money"

  "category"    : "categories"
  "query"       : "queries"
  "ability"     : "abilities"
  "agency"      : "agencies"
  "movie"       : "movies"

  "archive"     : "archives"

  "index"       : "indices"

  "wife"        : "wives"
  "safe"        : "saves"
  "half"        : "halves"

  "move"        : "moves"

  "salesperson" : "salespeople"
  "person"      : "people"

  "spokesman"   : "spokesmen"
  "man"         : "men"
  "woman"       : "women"

  "basis"       : "bases"
  "diagnosis"   : "diagnoses"
  "diagnosis_a" : "diagnosis_as"

  "datum"       : "data"
  "medium"      : "media"
  "stadium"     : "stadia"
  "analysis"    : "analyses"

  "node_child"  : "node_children"
  "child"       : "children"

  "experience"  : "experiences"
  "day"         : "days"

  "comment"     : "comments"
  "foobar"      : "foobars"
  "newsletter"  : "newsletters"

  "old_news"    : "old_news"
  "news"        : "news"

  "series"      : "series"
  "species"     : "species"

  "quiz"        : "quizzes"

  "perspective" : "perspectives"

  "ox"          : "oxen"
  "photo"       : "photos"
  "buffalo"     : "buffaloes"
  "tomato"      : "tomatoes"
  "dwarf"       : "dwarves"
  "elf"         : "elves"
  "information" : "information"
  "equipment"   : "equipment"
  "bus"         : "buses"
  "status"      : "statuses"
  "status_code" : "status_codes"
  "mouse"       : "mice"

  "louse"       : "lice"
  "house"       : "houses"
  "octopus"     : "octopi"
  "virus"       : "viri"
  "alias"       : "aliases"
  "portfolio"   : "portfolios"

  "vertex"      : "vertices"
  "matrix"      : "matrices"
  "matrix_fu"   : "matrix_fus"

  "axis"        : "axes"
  "taxi"        : "taxis"
  "testis"      : "testes"
  "crisis"      : "crises"

  "rice"        : "rice"
  "shoe"        : "shoes"

  "horse"       : "horses"
  "prize"       : "prizes"
  "edge"        : "edges"

  "cow"         : "kine"
  "database"    : "databases"

irregularities =
  'person' : 'people',
  'man'    : 'men',
  'child'  : 'children',
  'sex'    : 'sexes',
  'move'   : 'moves',

describe 'underscore.inflections', ->
  describe 'singularize', ->
    _.each singularToPlural, (value, key, list) ->
      it "should properly singularize #{value}", ->
        _.singularize(value).should.equal key

    _.each singularToPlural, (value, key, list) ->
      it "should properly singularize #{key}", ->
        _.singularize(key).should.equal key

    it "should inflect an empty string", ->
      _.pluralize("").should.equal ""

  describe 'pluralize', ->
    _.each singularToPlural, (value, key, list) ->
      it "should properly pluralize #{key}", ->
        _.pluralize(key).should.equal value

    _.each singularToPlural, (value, key, list) ->
      it "should properly pluralize #{value}", ->
        _.pluralize(value).should.equal value

    it "should inflect an empty string", ->
      _.pluralize("").should.equal ""

  describe 'uncountable', ->
    _.each defaultUncountables, (word) ->
      it "should test uncountability of #{word} with pluralize", ->
        _.pluralize(word).should.equal word

      it "should test uncountability of #{word} with pluralize", ->
        _.singularize(word).should.equal word

      it "should test uncountability of #{word} with pluralize", ->
        _.singularize(word).should.equal _.pluralize(word)

  describe 'irregulars', ->
    _.each irregularities, (value, key) ->
      it "should test irregularity between #{key} and #{value}", ->
        _.irregular key, value
        _.singularize(value).should.equal key
        _.pluralize(key).should.equal value

      it "should test pluralize of irregularity #{value} should be the same", ->
        _.irregular key, value
        _.pluralize(value).should.equal value

  describe 'overwriting', ->
    it "should override and switch back", ->
      _.singularize("series").should.equal "series"
      _.singular("series", "serie")
      _.singularize("series").should.equal "serie"
      _.uncountable "series"

  describe 'clear', ->
    it "should test clearing rules"
