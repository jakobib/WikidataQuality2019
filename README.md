# Data modeling in Wikidata: Requirements for a Wikidata schema language

*Accepted talk at the [Workshop on data quality management in Wikidata](https://fardamariam.wixsite.com/wikidatadqworkshop)*

## Abstract

The way statements about reality are modeled in Wikidata does not follow an
authoritative plan or consistent rules but it emerges from many loosely coupled
decisions by members of the Wikidata community. Modeling decisions should be
made explicit to support discussion and evaluation of data models and to improve
mutual understanding. A review of existing methods to document data models in
Wikidata results in requirements for a dedicated language to express data
models and schemas for the Wikidata database model.

Models can be expressed formally (property constraints, Shape Expressions...)
or informally (WikiProjects, infoboxes, implementations, examples...). Formal
data models allow to automatically check data against a model (validation) and
to infer or recommend additional statements but formal languages come with
complexity and constraints. Informal models, on the other hand, are flexible
and easier to understand but they come with fuzzyness and lack of automatic
processing. 

A modeling language for Wikidata should first aim at usability to allow
comprehensible and formal description of Wikidata data models. It is shown how
existing formal methods, despite their usefulness, do not meet this goal
because they are primarily bound by technical restrictions (RDF in the case of
ShEx, Wikidata statements in the case of property constraints). A new schema
language is sketched with requirements and examples. 

This contribution shall spur discussion about schema languages for Wikidata to
get to a flexible and powerful data modeling language that is easy to read,
write, and process.

## Keywords

* Wikidata ([Q2013])
* data modeling ([Q367664])
* modeling language ([Q1941921])

[Q367664]: http://www.wikidata.org/entity/Q367664
[Q2013]: http://www.wikidata.org/entity/Q2013
[Q1941921]:http://www.wikidata.org/entity/Q1941921

## Additional material

A draft of the schema language is available at <http://wikicite.org/kukulu/>
managed in a git repository at <https://github.com/wikicite/kukulu>.
