### Entities

**Entities** should be referencable by their plain ID:

* ~~`wd:`~~**`Q42`**
* ~~`wd:`~~**`P31`**, ~~`wdt:`~~**`P279`**...
* ~~`wd:`~~**`L7`**, ~~`wd:`~~**`L7-S1`**, ~~`wd:`~~**`L7-F4`**

Core elements of an entity should be accessible via their common (JSON) name:

* `Q42`**`.labels.en`** `== "Douglas Adams"`
* `L7`**`.lemmas.en`** `== "cat"`
* ...

### Data types

[**Data types**](https://www.wikidata.org/wiki/Help:Data_type) should be reserved words:

* ~~`wikibase:Wikibase`~~**`Item`**, ~~`wikibase:Wikibase`~~**`Property`**
* ~~`wikibase:`~~**`String`**, ~~`wikibase:Monolingual`~~**`Text`**, ~~`wikibase:`~~**`Math`**
* ~~`wikibase:`~~**`Time`**, ~~`wikibase:Globe`~~**`Coordinate`**, ~~`wikibase:`~~**`Quantity`**
* ~~`wikibase:External`~~**`Id`**, ~~`wikibase:`~~**`Url`**, ~~`wikibase:Commons`~~**`Media`**
* ~~`wikibase:Wikibase`~~**`Lexeme`**, ~~`wikibase:Wikibase`~~**`Sense`**, ~~`wikibase:Wikibase`~~**`Form`**
* ~~`wikibase:`~~**`Tabular`**~~`Data`~~, ~~`wikibase:Geo`~~**`Shape`**

**Methods** should be provided to for each data type, e.g.

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

### Statements

Simple statements can be expressed in QuickStatements syntax extended by variables:

    ?human P31  Q5          # variable item, property, value
    ?human P569 1952-03-11  # same with date as value
    Q42 P27 ?               # country of citizenship (value not bound to variable)
    ? ? ?                   # all possible statements

Ranks can be expressed with `!` (preferred rank), `~` (deprecated rank), and `*` (any rank):

    ?person P463 ?organization      # truthy member-of (default)
    ?person ~P463 ?organization     # deprecated member-of
    ?person !P463 ?organization     # preferred member-of (all statements)
    ?person *P463 ?organization     # member-of (all statements)

Property path inspired by SPARQL are useful:

    ?work P50 ? =>                  # if item has an author 
        ?work P31/P279* Q17537576   # then it must be subclass of creative work

## Qualifiers and References

*To be discussed, maybe:*

    ?work P463 ?organization { P580 ?start; S248 ?source } 

    ?work P463 ?organization:
        P580 ?start
        S248 ?source 

## Rules

    ?work P50 ?  => ...             # if item has an author 
    ?work P50 ? /=> ...             # if item has no author 
    not( ?work P50 ? ) => ...       # equivalent
    
