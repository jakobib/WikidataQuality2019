## Examples

### Constraint on details of the Tabular data type

> Data tables as value of property `P1082` (population) must have at least
> a column named `date` of type string with values being dates and
> a column named `population` of type number with non-negative integer values.

    ? P1082 ?population =>

        ?population.type == Tabular

        ?population.fields.date.type == String
        ?date in ?population.fields.date =>
            Time(?date).precision == 11

        ?population.fields.population.type == Number
        ?number in ?population.fields.population =>
            ?number >= 0

