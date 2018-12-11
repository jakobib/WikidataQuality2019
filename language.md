---
title: Kukulu
subtitle: A data language for Wikibase
---

# Introduction

**Kukulu** (named after the Hawaiian word *kūkulu*: to build, construct) is a formal language to express, query, and model data in the database model of [Wikibase]. Wikibase is primarily known for the knowledge base [Wikidata]. Its [database model] has official serializations in JSON and in RDF. Kukulu defines an alternative [serialization] with extensions to express [queries] and [constraints].

[Wikibase]: https://wikiba.se/
[Wikidata]: https://www.wikidata.org/
[YAML]: https://en.wikipedia.org/wiki/YAML

# Database model
[database model]: #wikibase-database-model

The **database model of Wikibase** (also referred to as *conceptual data model of Wikibase*) is [implemented canonically in PHP](https://github.com/wmde/WikibaseDataModel) and [described at MediaWiki.org](https://www.mediawiki.org/wiki/Wikibase/DataModel). The model is most visible through the Wikibase user interface.

## Overview

Basic understanding of the Wikibase database model and terminology is required to understand this document. A good starting point is the [Wikidata introduction] and help pages such as [Help:Items], [Help:Statements], and [Help:Lexemes]. The best way to get familiar with the database model is contributing to Wikidata.

[Wikidata introduction]: https://www.wikidata.org/wiki/Wikidata:Introduction
[Help:Items]: https://www.wikidata.org/wiki/Help:Items
[Help:Statements]: https://www.wikidata.org/wiki/Help:Statements
[Help:Lexemes]: https://www.wikidata.org/wiki/Help:Lexemes

## Data bindings

Official serializations of the Wikibase database model exist [in JSON](https://www.mediawiki.org/wiki/Wikibase/DataModel/JSON) and [in RDF](https://www.mediawiki.org/wiki/Wikibase/DataModel/RDF). Data bindings in addition to the PHP sources are available as part of programming libraries at least in JavaScript (*[wikidata-sdk]*), Java (*[Wikidata Toolkit]*), Python (*[Wikidata for Python]*), and .NET (*[Wiki Client Library]*).

Serializations in addition to the official JSON and RDF syntax exist as part of the [QuickStatements] tool and as part of the [GraphQL API], and as part of [wikidata-cli].

[QuickStatements]: https://www.wikidata.org/wiki/Help:QuickStatements
[GraphQL API]: https://tools.wmflabs.org/tptools/wdql.html

[wikidata-sdk]: https://www.npmjs.com/package/wikidata-sdk
[wikidata-cli]: https://www.npmjs.com/package/wikidata-cli
[Wikidata Toolkit]: https://www.mediawiki.org/wiki/Wikidata_Toolkit
[Wikidata for Python]: https://pypi.org/project/Wikidata/
[Wiki Client Library]: https://github.com/CXuesong/WikiClientLibrary

## Database model used in Kukulu

The current draft of Kukulu does not include the following elements that might be considered part of the Wikibase database model:

* MediaWiki revision ids and timestamps
* namespace ids
* badges
* claim identifiers
* reference hashes

# Serialization

Entities with their labels, aliases, claims etc. can be serialized in [key-value form], in [line-based form], and [mixed form].

## Key-value form

The **key-value form** is inspired by [YAML]:

~~~example
# entity identifier as root key
Q316:
  # labels and descriptions with language tag as key of each value
  labels:
    ar: حب
    en: love
    es: amor
  descriptions: 
    ar: شعور انجذاب عاطفي تجاه شخص
    en: strong, positive emotion based on affection
  aliases:
    # aliases given as list
    ar:
    - محبة
    - حُب
    # or as single value
    es: amar
  sitelinks:
    arwiki: حب
    enwiki: Love
    eswiki: Amor

  # TODO: exemplify claims, including ranks and special values
  claims:
    P31: Q9415
~~~

<!--
Values must be escaped in quotes if they contain the character sequence ` #`, if they start with any of `|`, `>`, `[`, or `{`... (*TODO*)
-->

*Note*: The structure of this format is also [used by wikidata-cli](https://github.com/maxlath/wikidata-edit/blob/master/docs/how_to.md#entity).

The entity identifier can be repeated, so data is merged (or overridden if merging is not possible):

~~~example
# first part
Q316:
  labels:
    en: love

# another entity
Q41577083:
  claims:
  - P570:
      value: 1586/7
      qualifiers:
        P1319: 1586/9

# second part
Q316:
  descriptions:
    en: strong, positive emotion based on affection
~~~

Lexemes have fields `lemmas`, `category`, `language`, `claims`, `senses`, and `forms`.

~~~example
L7:
  lemmas:
    en: cat
  category: Q1084   # abbreviated from "lexicalCategory"
  language: Q1860
  ...
  # TODO: exemplify senses and forms
~~~

## Line-based form

The **line-based form** is inspired by [QuickStatements] (QS):

<!--
*TODO:* Check whether this syntax is fully compatible with QS. Strings must be quoted and escaped, no?.
-->

~~~example
Q316 Len "love"
Q316 Den "strong, positive emotion based on affection"
Q316 Aes "amores" 
Q316 Sarwiki "حب"

# TODO: exemplify claims, including ranks and special values
Q316 P31 Q9415

# Value and qualifier
Q41577083 P570 1586/7 P1319 1586/9
~~~

Ranks can be expressed with `!` (preferred rank), `~` (deprecated rank), and `*` (any rank):

    ?person P463 ?organization      # truthy member-of (default)
    ?person ~P463 ?organization     # deprecated member-of
    ?person !P463 ?organization     # preferred member-of (all statements)
    ?person *P463 ?organization     # member-of (all statements)

## Mixed form

~~~example
# qualifiers as key-values
Q41577083 P570 1586/7:
  P1319: 1586/9

# values and qualifiers in key-value syntax
Q41577083 P570:
- value: 1586/7     # value
  P1319: 1586/9     # qualifier

# TODO: more variants...
~~~

# Values

## Entities

**Entities** should be referencable by their plain ID:

* ~~`wd:`~~**`Q42`**
* ~~`wd:`~~**`P31`**, ~~`wdt:`~~**`P279`**...
* ~~`wd:`~~**`L7`**, ~~`wd:`~~**`L7-S1`**, ~~`wd:`~~**`L7-F4`**

## Data types

[data type]: #data-types

[**Data types**](https://www.wikidata.org/wiki/Help:Data_type) should be reserved words:

* ~~`wikibase:Wikibase`~~**`Item`**, ~~`wikibase:Wikibase`~~**`Property`**
* ~~`wikibase:`~~**`String`**, ~~`wikibase:Monolingual`~~**`Text`**, ~~`wikibase:`~~**`Math`**
* ~~`wikibase:`~~**`Time`**, ~~`wikibase:Globe`~~**`Coordinate`**, ~~`wikibase:`~~**`Quantity`**
* ~~`wikibase:External`~~**`Id`**, ~~`wikibase:`~~**`Url`**, ~~`wikibase:Commons`~~**`Media`**
* ~~`wikibase:Wikibase`~~**`Lexeme`**, ~~`wikibase:Wikibase`~~**`Sense`**, ~~`wikibase:Wikibase`~~**`Form`**
* ~~`wikibase:`~~**`Tabular`**~~`Data`~~, ~~`wikibase:Geo`~~**`Shape`**

*TODO: document how to serialize data values*

# Queries

A [serialization] can be used as query to check whether the specified entities with given labels, aliases, claims etc. exists. [Variables] can be used as placeholders for unknown entities, properties and values.

## Variables

~~~example
?entity:
  labels:
    en: ?label
  aliases:
    en:
    - ?alias1
    - ?alias2
  claims:
    P31: ?class
    ?property: ?value   # any property except P31
~~~

~~~example
?work P463 ?organization:
  P580 ?start   # qualifier
  S248 ?source  # reference
~~~

*TODO: more complex examples*

## Attributes

Core elements of [entities] should be accessible via their common (JSON) name:

* `Q42`**`.labels.en`** `== "Douglas Adams"`
* `L7`**`.lemmas.en`** `== "cat"`
* ...

**Methods** should be provided to for each [data type], e.g.

* `Q42.`**`type`** `== Item`
* `Q42.`**`id`**
* `?text.`**`language`** `== "en"`
* `?lexeme.`**`lexicalCategory`** `== Q1084 # noun`
* `?tabular.`**`fields`**
* `2018-12-31.`**`precision`** `== 11 # days`

A very small subset of these methods is available in SPARQL but not beyond XSD
data types. Wikibase schema language should also do **implicit type casting**
(also useful for comparison operator `==`):

* `?uri.length` instead of `strlen(str(?uri))` 

Some data types can be converted to each other, e.g.

* `Time("2018-12-31") == 2018-12-31`

## Statements

Simple statements can be expressed in QuickStatements syntax extended by variables:

    ?human P31  Q5          # variable item, property, value
    ?human P569 1952-03-11  # same with date as value
    Q42 P27 ?               # country of citizenship (value not bound to variable)
    ? ? ?                   # all possible statements

Property path inspired by SPARQL are useful:

    ?work P50 ? =>                  # if item has an author 
        ?work P31/P279* Q17537576   # then it must be subclass of creative work

# Constraints

**Constraints** can be expressed as rules.

    ?work P50 ?  => ...             # if item has an author 
    ?work P50 ? /=> ...             # if item has no author 
    not( ?work P50 ? ) => ...       # equivalent
    
## Operators

### equality

    ==
    /=

### coparision

    >
    >=
    <
    <=

### set operators

    in

> Short names of entities (acronyms, abbreviations etc.) should also be aliases

~~~example
?entity P1813"short name" ?name =>
  ?name in ?entity.aliases
~~~

# Additional features

## Annotations

An entity or variable can *directly* be followed by a string:

~~~example
?person:
  P31"instance of" Q5"human"
  P569"date of birth" ?date
~~~

Applications can choose to ignore annotations, translate annotations, and/or check whether annotations match entity labels/lemmas.

Annotations can have languages: 

~~~example
?person:
  P31"είναι"@gr Q5"Mensch"@de
  P569"date of birth" ?date
~~~

The default annotation language can be set by a language tag, prepended with `@` on its own line:

~~~example
@gr
?person:
  P31"είναι" Q5"άνθρωπος"
  @en
  P569"date of birth" ?date
~~~

If annotations are checked, the following should be equivalent:

~~~example
?place Len "Shangri-La"

?place"Shangri-La"@en
~~~

## Junctions

Inspired by Perl6.

> extended type constraint on property P26: if A is spouse of B, then both must
> be instance of human, fictional character, person, or mythical character

    ?A P26 ?B  =>  ?A & ?B  P31  Q5 | Q95074 | Q215627 | Q4271324

Junctions could also be created by list operator `all` or `any`, respectively:

    ?A P26 ?B => all(?A, ?B) P31 any(Q5, Q95074, Q215627, Q4271324)

### Ranges

String, Time, and Quantity can be combined to ranges:

    "a"..."z"
    1901-01-01...2000-12-31
    1...42  

Indiviual values can be checked whether they are part of a range, for instance:

    ?date in 1901-01-01...2000-12-31

is equivalent to

    ?date >= 1901-01-01
    ?date <= 2000-12-13

# EBNF grammar

*This is work in progress!*

## Utilities

~~~ebnf
Label       ::= String [ "@" Language ]
Language    ::= LanguageTag [ "-" ]
IdNumber    ::= [1-9][0-9]+
~~~

## Data types

...

## Entity Types

### Items

Items can be referenced by their identifier, optionally followed by a label.

~~~ebnf
Item ::= "Q" ( IdNumber Label? | Label )
~~~

~~~example
Q42
Q42'Douglas Adams'
Q42'Douglas Adams'@en
~~~

Applications can give a warning if labels do not match identifiers, ignore the label, or change the label, for instance to switch language. Items can also be referenced purely by their name. For instance the following are equivalent:

~~~example
?q == Q"Douglas Adams" 
?q.type === Item && ?q.label == "Douglas Adams"
~~~

Applications can also choose to map them to identifiers in a preprocessing stage. 

### Properties

Properties can be referenced by their identifier and/or by their label in the same way like items.

~~~ebnf
Property ::= "P" ( IdNumber Label? | Label )
~~~

~~~examples
P596
P569'date of birth'
P'date of birth'
~~~

### Lexemes

Lexemes can be referenced by their identifier and/or by their lemma.

~~~ebnf
Lexeme ::= "L" ( IdNumber Label? | Label )
~~~

The language tag of a lemma refers to its spelling variant (not to be confused with the language of a lexeme). The following lines are equivalent:

~~~example
?l == L"first"@en
?l.lemma == "first"@en
?l.lemma.en == "first"
?l.lemma == "first" && ?l.variant == en
~~~

Specific attributes of labels include `lemma`, `language`, `category`, and `sense`, and `form`. 

~~~
?l.variant == en                &&
?l.language == Q1860"English"   &&
?l.category == Q1084"noun"  
?l.sense == L2-S1
~~~

### Forms

...

### Senses

...

# Background

Kukulu has been influenced by:

* QuickStatements
* YAML
* SPARQL
* N3
* ShEX
* Perl 6 (Junctions)
* Prolog/Datalog (deductive reasoning)
* ...

# References

* Wikibase DataModel. <https://github.com/wmde/WikibaseDataModel> (canonical implementation of the database model)
* Wikibase DataModel Serialization. <https://github.com/wmde/WikibaseDataModelSerialization> (JSON format)
* ...
