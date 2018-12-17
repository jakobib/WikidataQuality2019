## Examples

### Popular Wikidata property constraints

*TODO:* Take into account 

* exception to constraint (P2303)
* constraint scope (P4680)

#### Single value constraint 

A [single value constraint](https://www.wikidata.org/wiki/Help:Property_constraints_portal/Single_value)
specifies that a property generally only has a single, value except when values can be distinguished with
selected qualifiers.

    ?property P2302 Q19474404"single value constraint" 
        P4155 ?*separators

*TODO:* cannot be expressed in Kukulu?
      
#### Distinct values constraint

A [distinct values constraint](https://www.wikidata.org/wiki/Help:Property_constraints_portal/Unique_value)
specifies that values for this property should be unique across the database, and no other entities should
have the same value in a statement for this property.

    ?property P2302 Q21502410"distinct values constraint"
    ?A ?property ?value 
    ?B ?property ?value
    
    => ?A /= ?B

#### Format constraint

A [format constraint](https://www.wikidata.org/wiki/Help:Property_constraints_portal/Format)
specifies that values for a property should conform to a certain pattern.

    ?property P2302 Q21502404"format constraint" P1793 ?regex
    ?item ?property ?value
    
    => ?value =~ ?regex

#### Type constraint

A [type constraint](https://www.wikidata.org/wiki/Help:Property_constraints_portal/Type)
specifies that entities with a given property should be instance of at least one of a
given set of type. This set is also known as the *domain* of a property.

    ?property P2302 Q21503250"type constraint"
      P2309 ?relation
      P2308 ?+classes
    => 
       ?item ?property ?
       =>
         ?relation == Q21503252  =>
           ?item P31/P279* ?+classes
         ?relation == Q21514624  =>  
           ?item P279+ ?+classes
         ?relation == Q30208840  =>
           ?item P31/P279*|P279+ ?+classes

#### Value type constraint

A [value type constraint](https://www.wikidata.org/wiki/Special:MyLanguage/Help:Property_constraints_portal/Value_type)
specifies that values of a given property should be instance of a given type. 
This is also known as the *range* of a property.

    ?property P2302 Q21510865"value type constraint"
      P2309 ?relation
      P2308 ?+classes
    =>
       ? ?property ?value
       =>
         ?relation == Q21503252  =>
           ?value P31/P279* ?+classes
         ?relation == Q21514624  =>  
           ?value P279+ ?+classes
         ?relation == Q30208840  =>
           ?value P31/P279*|P279+ ?+classes

### Other property constraints

#### multi-value constraint

A [multi-value constraint](https://www.wikidata.org/wiki/Special:MyLanguage/Help:Property_constraints_portal/Multi_value)
specifies that a property should have multiple value.

    ?property P2302 Q21510857"multi-value constraint"
    =>
      ?item ?property ?
      =>
        ?item ?property ?valueA
        ?item ?property ?valueB

#### Commons link constraint 

The [commons link constraint](https://www.wikidata.org/wiki/Help:Property_constraints_portal/Commons_link)
is only used by the user interface and to resolve links to entities at [Wikimedia Commons] but it is not
part of property values.

[Wikimedia Commons]: https://commons.wikimedia.org

#### Allowed qualifiers constraint

An [allowed qualifiers constraint](https://www.wikidata.org/wiki/Help:Property_constraints_portal/Qualifiers)
...

#### Allowed units constraint

An [allowed units constraint](https://www.wikidata.org/wiki/Help:Property_constraints_portal/Units)
...

#### conflicts-with constraint 

A [conflicts-with constraint](https://www.wikidata.org/wiki/Help:Property_constraints_portal/Conflicts_with)
specifies that items using this property should not have a certain other statement.

    ?property P2302 "conflicts-with constraint"
      P2306 ?conflictingProperty
    =>
       ?item ?property ?value               # if an item uses this property
       =>                                   # then
         ?item ?conflictingProperty ?value  # it must not use conflicting property, except... 
         => 
            ?property P2305 ?+conflictingValues  # if conflicting values are listed
            ?value no ?+conflictingValues        # but the property values is none of them

#### difference within range constraint 

#### inverse constraint 

#### item requires statement constraint

#### mandatory qualifier constraint 

#### one-of constraint

#### range constraint 

#### symmetric constraint

#### value requires statement constraint

#### no bounds constraint

#### integer constraint 

#### none of constraint

#### single best value constraint

#### citation needed constraint

#### allowed entity types constraint

### Examples translated from GraphQL 

> Retrieve the VIAF id of Q260 with some data about the property and references 

GraphQL:

    {
      viaf: item(id: "Q260") {
        statements(propertyIds: "P214") {
          mainsnak {
            ... on PropertyValueSnak {
              property { id }
              value { ... on StringValue { value } }
            }
          }
          references {
            snaks(propertyIds: ["P143"]) {
              ... on PropertyValueSnak {
                value { ... on Entity { id } }
              }
            }
          }
        }
      }
    }

SPARQL:

    SELECT ?viaf ?importedFrom WHERE {
      wd:Q260 p:P214 [
        ps:P214 ?viaf ; 
        prov:wasDerivedFrom [ pr:P143 ?importedFrom ]
      ]
    }

Kukulu:

    Q260 P214 ?viaf:
      S143: ?importedFrom


#### ...

...

### Examples translated from GraphQL 

> Retrieve the VIAF id of Q260 with some data about the property and references 

GraphQL:

    {
      viaf: item(id: "Q260") {
        statements(propertyIds: "P214") {
          mainsnak {
            ... on PropertyValueSnak {
              property { id }
              value { ... on StringValue { value } }
            }
          }
          references {
            snaks(propertyIds: ["P143"]) {
              ... on PropertyValueSnak {
                value { ... on Entity { id } }
              }
            }
          }
        }
      }
    }

SPARQL:

    SELECT ?viaf ?importedFrom WHERE {
      wd:Q260 p:P214 [
        ps:P214 ?viaf ; 
        prov:wasDerivedFrom [ pr:P143 ?importedFrom ]
      ]
    }

Kukulu:

    Q260 P214 ?viaf:
      S143: ?importedFrom


#### ...

...

### Examples translated from GraphQL 

> Retrieve the VIAF id of Q260 with some data about the property and references 

GraphQL:

    {
      viaf: item(id: "Q260") {
        statements(propertyIds: "P214") {
          mainsnak {
            ... on PropertyValueSnak {
              property { id }
              value { ... on StringValue { value } }
            }
          }
          references {
            snaks(propertyIds: ["P143"]) {
              ... on PropertyValueSnak {
                value { ... on Entity { id } }
              }
            }
          }
        }
      }
    }

SPARQL:

    SELECT ?viaf ?importedFrom WHERE {
      wd:Q260 p:P214 [
        ps:P214 ?viaf ; 
        prov:wasDerivedFrom [ pr:P143 ?importedFrom ]
      ]
    }

Kukulu:

    Q260 P214 ?viaf:
      S143: ?importedFrom

### Constraint on details of the Tabular data type

> Data tables as value of property `P1082` (population) must have at least
> a column named `date` of type string with values being dates and
> a column named `population` of type number with non-negative integer values.

Kukulu:

    ? P1082 ?population =>

      ?population a Table

      ?population.fields.date.type == String
      ?date in ?population.fields.date =>
        Time(?date).precision == 11     # cast string to Time

      ?population.fields.population.type == Number
      ?number in ?population.fields.population =>
        ?number >= 0

