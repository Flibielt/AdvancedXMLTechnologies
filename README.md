# Advanced XML technologies project

A home work project for Advanced XML technologies at the University of Debrecen.

## Used technologies

* XML
* JSON
* XQuery 3.1

## Datasource

Olympic Track & Field Results: [link](https://www.kaggle.com/jayrav13/olympic-track-field-results?select=results.json)

## Assignments by results

### One atomic value

* Longest game name
    * Query: [get_longest_name.xquery](get_longest_name.xquery)

* The biggest gold count by a single athlete
    * Query: [most_gold_count.xquery](most_gold_count.xquery)

* The athlete with the biggest gold count
    * Query: [athlete_with_most_gold_count.xquery](athlete_with_most_gold_count.xquery)

### Array or object in JSON

* List of games by gender
    * Query: [list_games_by_gender.xquery](list_games_by_gender.xquery)

* List of athletes with the count of their gold medal
    * Query: [athlete_gold_count.xquery](athlete_gold_count.xquery)

### XML with schema validation

* List the Hungarian results
    * Query: [get_hungarians.xquery](get_hungarians.xquery)
    * Schema: [get_hungarians.xsd](get_hungarians.xsd)

* List every athlete, who won a gold medal
    * Query: [winners.xquery](winners.xquery)
    * Schema: [winners.xsd](winners.xsd)

* List every gold medal by games
    * Query: [gold_results.xquery](gold_results.xquery)
    * Schema: [gold_results.xsd](gold_results.xsd)

* List every athlete with his/her results
    * Query: [athletes_with_results.xquery](athletes_with_results.xquery)
    * Schema: [athletes_with_results.xsd](athletes_with_results.xsd)

### HTML

* List of games with gender and the URL of the game description from [olympic.org](olympic.org)

    * Query: [list_games_html.xquery](list_games_html.xquery)