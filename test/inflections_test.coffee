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

camelToUnderscore =
  "Product"               : "product"
  "SpecialGuest"          : "special_guest"
  "ApplicationController" : "application_controller"
  "Area51Controller"      : "area51_controller"

camelToUnderscoreWithoutReverse =
  "HTMLTidy"              : "html_tidy"
  "HTMLTidyGenerator"     : "html_tidy_generator"
  "FreeBSD"               : "free_bsd"
  "HTML"                  : "html"

underscoreToLowerCamel =
  "product"                : "product"
  "special_guest"          : "specialGuest"
  "application_controller" : "applicationController"
  "area51_controller"      : "area51Controller"

underscoreToHuman =
  "employee_salary"       : "Employee salary"
  "employee_id"           : "Employee"
  "underground"           : "Underground"

mixtureToTitleCase =
  'active_record'         : 'Active Record'
  'ActiveRecord'          : 'Active Record'
  'action web service'    : 'Action Web Service'
  'Action Web Service'    : 'Action Web Service'
  'Action web service'    : 'Action Web Service'
  'actionwebservice'      : 'Actionwebservice'
  'Actionwebservice'      : 'Actionwebservice'
  "david's code"          : "David's Code"
  "David's code"          : "David's Code"
  "david's Code"          : "David's Code"
  "sgt. pepper's"         : "Sgt. Pepper's"
  "i've just seen a face" : "I've Just Seen A Face"
  "maybe you'll be there" : "Maybe You'll Be There"
  "¿por qué?"             : '¿Por Qué?'
  "Fred’s"                : "Fred’s"
  "Fred`s"                : "Fred`s"

irregularities =
  'person' : 'people',
  'man'    : 'men',
  'child'  : 'children',
  'sex'    : 'sexes',
  'move'   : 'moves',
  'misc.'  : 'misc.',

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

    it "should inflect with a count", ->
      _.pluralize("count", 1).should.equal "1 count"
      _.pluralize("count", 2).should.equal "2 counts"
      _.pluralize("count", '1').should.equal "1 count"
      _.pluralize("count", '2').should.equal "2 counts"
      _.pluralize("count", '1,066').should.equal "1,066 counts"
      _.pluralize("count", '1.25').should.equal "1.25 counts"
      _.pluralize("count", '1.0').should.equal "1.0 count"
      _.pluralize("count", '1.00').should.equal "1.00 count"
      _.pluralize("count", 0, plural: "counters").should.equal "0 counters"
      _.pluralize("count", null, plural: "counters").should.equal "0 counters"
      _.pluralize("person", 2).should.equal "2 people"
      _.pluralize("buffalo", 10).should.equal "10 buffaloes"
      _.pluralize("berry", 1).should.equal "1 berry"
      _.pluralize("berry", 12).should.equal "12 berries"

    it "should inflect with count, but not show number", ->
      _.pluralize("count", 1, showNumber: false).should.equal "count"
      _.pluralize("count", 2, showNumber: false).should.equal "counts"
      _.pluralize("count", '1', showNumber: false).should.equal "count"
      _.pluralize("count", '2', showNumber: false).should.equal "counts"
      _.pluralize("count", '1,066', showNumber: false).should.equal "counts"
      _.pluralize("count", '1.25', showNumber: false).should.equal "counts"
      _.pluralize("count", '1.0', showNumber: false).should.equal "count"
      _.pluralize("count", '1.00', showNumber: false).should.equal "count"
      _.pluralize("count", 0, plural: "counters", showNumber: false).should.equal "counters"
      _.pluralize("count", null, plural: "counters", showNumber: false).should.equal "counters"
      _.pluralize("person", 2, showNumber: false).should.equal "people"
      _.pluralize("buffalo", 10, showNumber: false).should.equal "buffaloes"
      _.pluralize("berry", 1, showNumber: false).should.equal "berry"
      _.pluralize("berry", 12, showNumber: false).should.equal "berries"

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

  describe 'camelize', ->
    it "should propertly camelize", ->
      _.each camelToUnderscore, (value, key, list) ->
        _.camelize(value).should.equal key

    it "should downcase the first character if passed false as a second argument", ->
      _.camelize('Capital', false).should.equal 'capital'

    it "should remove underscores", ->
      _.camelize('Camel_Case').should.equal 'CamelCase'

  describe 'acronyms', ->
    before ->
      _.acronym('API')
      _.acronym('HTML')
      _.acronym('HTTP')
      _.acronym('RESTful')
      _.acronym('W3C')
      _.acronym('PhD')
      _.acronym('RoR')
      _.acronym('SSL')

    #  camelize             underscore            humanize              titleize
    _.each [
      ["API",               "api",                "API",                "API"],
      ["APIController",     "api_controller",     "API controller",     "API Controller"],
      ["HTTPAPI",           "http_api",           "HTTP API",           "HTTP API"],
      ["SSLError",          "ssl_error",          "SSL error",          "SSL Error"],
      ["RESTful",           "restful",            "RESTful",            "RESTful"],
      ["RESTfulController", "restful_controller", "RESTful controller", "RESTful Controller"],
      ["IHeartW3C",         "i_heart_w3c",        "I heart W3C",        "I Heart W3C"],
      ["PhDRequired",       "phd_required",       "PhD required",       "PhD Required"],
      ["IRoRU",             "i_ror_u",            "I RoR u",            "I RoR U"],
      ["RESTfulHTTPAPI",    "restful_http_api",   "RESTful HTTP API",   "RESTful HTTP API"],

      # misdirection
      ["Capistrano",        "capistrano",         "Capistrano",         "Capistrano"],
      ["CapiController",    "capi_controller",    "Capi controller",    "Capi Controller"],
      ["HttpsApis",         "https_apis",         "Https apis",         "Https Apis"],
      ["Html5",             "html5",              "Html5",              "Html5"],
      ["Restfully",         "restfully",          "Restfully",          "Restfully"],
      ["RoRails",           "ro_rails",           "Ro rails",           "Ro Rails"]
    ], (t) ->
      camel = t[0]
      under = t[1]
      human = t[2]
      title = t[3]
      it 'should camelize as underscored', ->
        _.camelize(under).should.equal camel
      it 'should not change already camel cased', ->
        _.camelize(camel).should.equal camel
      it 'should not modify already underscored', ->
        _.underscore(under).should.equal under
      it 'should underscore camel cased', ->
        _.underscore(camel).should.equal under
      it 'titleizes underscored text as expected', ->
        _.titleize(under).should.equal title
      it 'titleizes camelcase text as expected', ->
        _.titleize(camel).should.equal title
      it 'should humanize as expected', ->
        _.humanize(under).should.equal human

    describe 'RESTfulHTTPAPI', ->
      it 'does its thing', ->
        _.underscore('RESTfulHTTPAPI').should.equal 'restful_http_api'

  describe 'acronym override', ->
    before ->
      _.acronym('API')
      _.acronym('LegacyApi')

    it 'honors new acronym', ->
      _.camelize('legacyapi').should.equal 'LegacyApi'

    it 'does not match with underscore', ->
      _.camelize('legacy_api').should.equal 'LegacyAPI'

    it 'matches when delimited in a longer string', ->
      _.camelize('some_legacyapi').should.equal 'SomeLegacyApi'

    it 'does not match when not delimited', ->
      _.camelize('nonlegacyapi').should.equal 'Nonlegacyapi'

  describe 'acronym camelize lower', ->
    before ->
      _.acronym('API')
      _.acronym('HTML')

    it 'does not camelize first letter', ->
      _.camelize('html_api', false).should.equal 'htmlAPI'
      _.camelize('htmlAPI',  false).should.equal 'htmlAPI'
      _.camelize('HTMLAPI',  false).should.equal 'htmlAPI'

  describe 'underscore acronym sequence', ->
    before ->
      _.acronym('API')
      _.acronym('JSON')
      _.acronym('HTML')

    it 'deliniates on acronym boundaries', ->
      _.underscore('JSONHTMLAPI').should.equal 'json_html_api'

  describe 'underscore', ->
    _.each camelToUnderscore, (underscore, camel) ->
      it 'should underscore as expected', ->
        _.underscore(camel).should.equal underscore

    _.each camelToUnderscoreWithoutReverse, (underscore, camel) ->
      it 'should underscore without reverse as expected', ->
        _.underscore(camel).should.equal underscore

  describe 'humanize', ->
    _.each underscoreToHuman, (human, underscore) ->
      it 'should humanize as expected', ->
        _.humanize(underscore).should.equal human

  describe 'humanize by rule', ->
    before ->
      _.human /_cnt$/i, '_count'
      _.human /^prefix/i, ''

    it 'applies the custom rules', ->
      _.humanize('jargon_cnt').should.equal 'Jargon count'
      _.humanize('prefix_request').should.equal 'Request'

  describe 'humanize by string', ->
    before ->
      _.human 'col_rpted_bugs', 'Reported bugs'

    it 'performs the string replacement', ->
      _.humanize('col_rpted_bugs').should.equal 'Reported bugs'
      _.humanize('COL_rpted_bugs').should.equal 'Col rpted bugs'

  describe 'titleize', ->
    _.each mixtureToTitleCase, (titleized, before) ->
      it "titleizes #{before}", ->
        _.titleize(before).should.equal titleized
