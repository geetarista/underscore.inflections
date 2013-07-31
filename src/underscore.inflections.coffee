# **underscore.inflections** is an [underscore.js](http://underscorejs.org) mixin
# that provides methods for inflection of words.
class Inflections
  # Common uncountable words
  defaultUncountables: [
    'equipment', 'information', 'rice', 'money', 'species', 'series',
    'fish', 'sheep', 'jeans', 'moose', 'deer', 'news', 'music'
  ]

  # Plural rules
  defaultPluralRules: [
    [/$/, 's']
    [/s$/i, 's']
    [/^(ax|test)is$/i, '$1es']
    [/(octop|vir)us$/i, '$1i']
    [/(octop|vir)i$/i, '$1i']
    [/(alias|status)$/i, '$1es']
    [/(bu)s$/i, '$1ses']
    [/(buffal|tomat)o$/i, '$1oes']
    [/([ti])um$/i, '$1a']
    [/([ti])a$/i, '$1a']
    [/sis$/i, 'ses']
    [/(?:([^f])fe|([lr])f)$/i, '$1$2ves']
    [/(hive)$/i, '$1s']
    [/([^aeiouy]|qu)y$/i, '$1ies']
    [/(x|ch|ss|sh)$/i, '$1es']
    [/(matr|vert|ind)(?:ix|ex)$/i, '$1ices']
    [/(m|l)ouse$/i, '$1ice']
    [/(m|l)ice$/i, '$1ice']
    [/^(ox)$/i, '$1en']
    [/^(oxen)$/i, '$1']
    [/(quiz)$/i, '$1zes']
  ]

  # Singular rules
  defaultSingularRules: [
    [/s$/i, '']
    [/(ss)$/i, '$1']
    [/(n)ews$/i, '$1ews']
    [/([ti])a$/i, '$1um']
    [/((a)naly|(b)a|(d)iagno|(p)arenthe|(p)rogno|(s)ynop|(t)he)(sis|ses)$/i, '$1$2sis']
    [/(^analy)(sis|ses)$/i, '$1sis']
    [/([^f])ves$/i, '$1fe']
    [/(hive)s$/i, '$1']
    [/(tive)s$/i, '$1']
    [/([lr])ves$/i, '$1f']
    [/([^aeiouy]|qu)ies$/i, '$1y']
    [/(s)eries$/i, '$1eries']
    [/(m)ovies$/i, '$1ovie']
    [/(x|ch|ss|sh)es$/i, '$1']
    [/(m|l)ice$/i, '$1ouse']
    [/(bus)(es)?$/i, '$1']
    [/(o)es$/i, '$1']
    [/(shoe)s$/i, '$1']
    [/(cris|test)(is|es)$/i, '$1is']
    [/^(a)x[ie]s$/i, '$1xis']
    [/(octop|vir)(us|i)$/i, '$1us']
    [/(alias|status)(es)?$/i, '$1']
    [/^(ox)en/i, '$1']
    [/(vert|ind)ices$/i, '$1ex']
    [/(matr)ices$/i, '$1ix']
    [/(quiz)zes$/i, '$1']
    [/(database)s$/i, '$1']
  ]

  # Irregular rules
  defaultIrregularRules: [
    ['person', 'people']
    ['man', 'men']
    ['child', 'children']
    ['sex', 'sexes']
    ['move', 'moves']
    ['cow', 'kine']
    ['zombie', 'zombies']
  ]

  defaultHumanRules: []

  # Set up arrays and apply default rules
  constructor: ->
    @plurals = []
    @singulars = []
    @uncountables = []
    @humans = []
    @acronyms = {}

    @applyDefaultRules()

  # Apply all default rules
  applyDefaultRules: =>
    @applyDefaultUncountables()
    @applyDefaultPlurals()
    @applyDefaultSingulars()
    @applyDefaultIrregulars()

  # Apply rules for list of uncountables
  applyDefaultUncountables: => @uncountable @defaultUncountables

  # Apply rules for list of default plurals
  applyDefaultPlurals: =>
    _.each @defaultPluralRules, (rule) =>
      [regex, capture] = rule
      @plural regex, capture

  # Apply rules for list of default singulars
  applyDefaultSingulars: ->
    _.each @defaultSingularRules, (rule) =>
      [regex, capture] = rule
      @singular regex, capture

  # Apply rules for list of default irregulars
  applyDefaultIrregulars: ->
    _.each @defaultIrregularRules, (rule) =>
      [singular, plural] = rule
      @irregular singular, plural

  acronym: (word) =>
    @acronyms[word.toLowerCase()] = word
    @acronym_matchers = _.values(@acronyms).join("|")

  # Specifies a new pluralization rule and its replacement. The rule can either be a string or a regular expression.
  # The replacement should always be a string that may include references to the matched data from the rule.
  plural: (rule, replacement) =>
    delete @uncountables[_.indexOf(@uncountables, rule)] if typeof rule is 'string'
    delete @uncountables[_.indexOf(@uncountables, replacement)]
    @plurals.unshift [rule, replacement]

  # Specifies a new singularization rule and its replacement. The rule can either be a string or a regular expression.
  # The replacement should always be a string that may include references to the matched data from the rule.
  singular: (rule, replacement) =>
    delete @uncountables[_.indexOf(@uncountables, rule)] if typeof rule is 'string'
    delete @uncountables[_.indexOf(@uncountables, replacement)]
    @singulars.unshift [rule, replacement]

  # Specifies a new irregular that applies to both pluralization and singularization at the same time. This can only be used
  # for strings, not regular expressions. You simply pass the irregular in singular and plural form.
  #
  # Examples:
  #
  #     _.irregular('octopus', 'octopi')
  #     _.irregular('person', 'people')
  irregular: (singular, plural) =>
    delete @uncountables[_.indexOf(@uncountables, singular)]
    delete @uncountables[_.indexOf(@uncountables, plural)]
    if singular.substring(0,1).toUpperCase() is plural.substring(0,1).toUpperCase()
      @plural(new RegExp("(#{singular.substring(0,1)})#{singular.substring(1,plural.length)}$", "i"), '$1' + plural.substring(1, plural.length))
      @plural(new RegExp("(#{plural.substring(0,1)})#{plural.substring(1,plural.length)}$", "i"), '$1' + plural.substring(1, plural.length))
      @singular(new RegExp("(#{plural.substring(0,1)})#{plural.substring(1,plural.length)}$", "i"), '$1' + singular.substring(1, plural.length))
    else
      @plural(new RegExp("#{singular.substring(0,1)}#{singular.substring(1,plural.length)}$", "i"), plural.substring(0,1) + plural.substring(1,plural.length))
      @plural(new RegExp("#{singular.substring(0,1)}#{singular.substring(1,plural.length)}$", "i"), plural.substring(0,1) + plural.substring(1,plural.length))
      @plural(new RegExp("#{plural.substring(0,1)}#{plural.substring(1,plural.length)}$", "i"), plural.substring(0,1) + plural.substring(1,plural.length))
      @plural(new RegExp("#{plural.substring(0,1)}#{plural.substring(1,plural.length)}$", "i"), plural.substring(0,1) + plural.substring(1,plural.length))
      @singular(new RegExp("#{plural.substring(0,1)}#{plural.substring(1,plural.length)}$", "i"), singular.substring(0,1) + singular.substring(1,plural.length))
      @singular(new RegExp("#{plural.substring(0,1)}#{plural.substring(1,plural.length)}$", "i"), singular.substring(0,1) + singular.substring(1,plural.length))

  # Add uncountable words that shouldn't be attempted inflected.
  #
  # Examples:
  #
  #     _.uncountable("money")
  #     _.uncountable("money", "information")
  #     _.uncountable(["money", "information", "rice"])
  uncountable: (words...) =>
    @uncountables.push(words)
    @uncountables = _.flatten @uncountables

  human: (rule, replacement) =>
    @humans.unshift([rule, replacement])

  # Clears the loaded inflections within a given scope (default is `'all'`).
  # Give the scope as a symbol of the inflection type, the options are: `'plurals'`,
  # `'singulars'`, `'uncountables'`, `'humans'`.
  #
  # Examples:
  #
  #     _.clearInflections('all')
  #     _.clearInflections('plurals')
  clearInflections: (scope = 'all') =>
    @[scope] = []

  # Pluralizes a word
  #
  # Examples:
  #
  #     _.pluralize('')
  pluralize: (word, count, options = {}) =>
    options = _.extend { plural: undefined, showNumber: true }, options

    if count isnt undefined
      result = ""
      result += "#{count ? 0} " if options.showNumber is true
      result += if count is 1 or count?.toString?().match(/^1(\.0+)?$/) then word else (options.plural ? @pluralize(word))
    else
      @apply_inflections(word, @plurals)

  # Singularizes a word
  singularize: (word) =>
    @apply_inflections(word, @singulars)

  camelize: (term, uppercase_first_letter = true) =>
    if uppercase_first_letter
      term = term.replace /^[a-z\d]*/, (a) => @acronyms[a] || _.capitalize(a)
    else
      term = term.replace ///^(?:#{@acronym_matchers}(?=\b|[A-Z_])|\w)///, (a) -> a.toLowerCase()
    term = term.replace /(?:_|(\/))([a-z\d]*)/gi, (match, $1, $2, idx, string) =>
      $1 ||= ''
      "#{$1}#{@acronyms[$2] || _.capitalize($2)}"

  underscore: (camel_cased_word) =>
    word = camel_cased_word
    word = word.replace ///(?:([A-Za-z\d])|^)(#{@acronym_matchers})(?=\b|[^a-z])///g, (match, $1, $2) ->
      "#{$1 || ''}#{if $1 then '_' else ''}#{$2.toLowerCase()}"
    word = word.replace /([A-Z\d]+)([A-Z][a-z])/g, "$1_$2"
    word = word.replace /([a-z\d])([A-Z])/g, "$1_$2"
    word = word.replace '-', '_'
    word = word.toLowerCase()

  humanize: (lower_case_and_underscored_word) =>
    word = lower_case_and_underscored_word
    for human in @humans
      rule = human[0]
      replacement = human[1]
      if (rule.test? && rule.test word) || (rule.indexOf? && word.indexOf(rule) >= 0)
        word = word.replace rule, replacement
        break
    word = word.replace /_id$/g, ''
    word = word.replace /_/g, ' '
    word = word.replace /([a-z\d]*)/gi, (match) =>
      @acronyms[match] || match.toLowerCase()
    word = _.trim(word).replace /^\w/g, (match) -> match.toUpperCase()

  titleize: (word) =>
    @humanize(@underscore(word)).replace /([\s¿]+)([a-z])/g, (match, boundary, letter, idx, string) ->
      match.replace(letter, letter.toUpperCase())

  # Apple rules to a given word. If the last word fo the string is uncountable,
  # just return it. Otherwise, make the replacement and return that.
  apply_inflections: (word, rules) =>
    if (!word)
      return word
    else
      result = word
      match = result.toLowerCase().match(/\b\w+$/)
      if match and _.indexOf(@uncountables, match[0]) isnt -1
        result
      else
        for rule in rules
          [regex, capture] = rule
          if result.match regex
            result = result.replace regex, capture
            break
        result

# Export to window or exports
root = exports ? @

# Require underscore
_ = root._ or require 'underscore'

# Require underscore.string
if require?
  _.str = require 'underscore.string'
  _.mixin _.str.exports()
  _.str.include 'Underscore.string', 'string'
else
  _.mixin _.str.exports()

# Include Inflections as a mixin to underscore
if typeof exports is 'undefined'
  _.mixin new Inflections
else
  module.exports = new Inflections
