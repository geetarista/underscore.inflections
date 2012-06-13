# underscore.inflections [![Build Status](https://secure.travis-ci.org/geetarista/underscore.inflections.png)](http://travis-ci.org/geetarista/underscore.inflections)

Port of ActiveSupport::Inflector::Inflections for Underscore.js.

Works with browser or Node.js.

## Introduction

I created this underscore mixin after trying out every other inflection library out there. I've created this as a direct port of Rails' version as much as possible.

Note that right now, this only handles methods found in ActiveSupport::Inflector::Inflections since that's all I need right now. I may eventually split this out into separate inflector mixins that match all of ActiveSupport's.

## Setup

### Browser

Include both underscore.js and underscore.inflections on your page:

```html
<script src="underscore.js" type="text/javascript"></script>
<script src="underscore.inflections.js" type="text/javascript"></script>
```

### Node.js

First, install the mixin through npm:

```bash
npm install underscore.inflections
```

Require underscore.js and underscore.inflections:

```javascript
var _ = require('underscore');
_.mixing(require('underscore.inflections'));
```

**Note**: When using underscore in Node's REPL, be sure to choose a variable other than `_`, as that is a special symbol used for showing the last return value.

## Usage

### Singularize

Converts a word to its singular form.

Examples:

```javascript
_.singularize('posts');    //=> 'post'
_.singularize('octopi');   //=> 'octopus'
_.singularize('sheep');    //=> 'sheep'
_.singularize('words');    //=> 'words'
```

### Pluralize

Converts a word to its pluralized form.

Examples:

```javascript
_.singularize('post');      //=> 'posts'
_.singularize('octopus');   //=> 'octopi'
_.singularize('sheep');     //=> 'sheep'
_.singularize('words');     //=> 'words'
```

## Customizing

### Singular

Adds a rule for singularizing a word.

Example:

```javascript
_.singular(/^(ox)en/i, '\1');
```

### Plural

Adds a rule for pluralizing a word.

Example:

```javascript
_.plural(/^(ox)$/i, '\1en');
```

### Irregular

Adds a rule for an irregular word.

Example:

```javascript
_.irregular('person', 'people');
```

### Uncountable

Adds a rule for an uncountable word or words.

Example:

```javascript
_.uncountable(['fish', 'sheep']);
```

## License

MIT. See `LICENSE`.
