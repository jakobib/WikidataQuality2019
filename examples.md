## Examples

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

      ?population.type == Tabular

      ?population.fields.date.type == String
      ?date in ?population.fields.date =>
        Time(?date).precision == 11     # cast string to Time

      ?population.fields.population.type == Number
      ?number in ?population.fields.population =>
        ?number >= 0

