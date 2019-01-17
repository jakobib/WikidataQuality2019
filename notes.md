# Datatypes

Core datatypes of Wikibase:

...

Core data types of RDF:

* xsd:date, xsd:dateTime, xsd:boolean...
* `xsd:string` (RDF 1.0), `rdf:langString` (RDF 1.0)
<https://www.w3.org/TR/rdf11-concepts/#xsd-datatypes>

Why should a DB language use differnt types?

# Requirements

* comprehensible
* expressive
* ...

data modeling 

* shall bridge the gap between mind and data
* is affected by reality and by data description languages
* is never right or wrong but useful or not
* always muliple models exist
 
Communicate data models through exchange of rules and examples

# Abstract

It is argued that current languages (ShEx)
focus on Wikidata serialiation in RDF instead of the conceptual data model of Wikidata 

## Data modeling in Wikidata

> Data modeling in Wikidata happens through the use of properties and the use of class-subclass relationships [5, 32]

Misconception: data modeling is not about classes and properties
(P31/P279 are overrated). This taxonomy 

---

Requirements: support of Wikibase data types

* String: substring, regex...
* Coordinate: distance...
* ...
* Tabular: table schema, [CSV fragment id]...

[CSV fragment id](https://tools.ietf.org/html/rfc7111)

---

## Pro/con

Property constraints:

- no readable serialization
- must be part of the database they describe
- cannot be shared easily
- missing rules

## Serialization

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


## Foundations

Data Structuring Language

## 

data structuring language       Schema languages
------------------------------- --------------------------------
character string                regular expressions, BNF...
JSON                            JSON Schema, Rx, Kwalify...


## Previous works

* Listeria: SPARQL-Queries with 

$q_{invalid} \longrightarrow \varnothing$

* Programming libraries for Wikidata (Lua, wikidata-sdk, ...)

# Core message

Wikibase data model is not SQL, JSON, RDF, CSV... but a database model of its own
(show image of DSL from format.gbv.de)

# Motivation

Wikibase is a database.

*Where is the Wikibase command line?*
