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

### Array or object in JSON

* List of games by gender
    * Query: [list_games_by_gender.xquery](list_games_by_gender.xquery)

* List of athletes with the count of their gold medal
    * Query: [athlete_gold_count.xquery](athlete_gold_count.xquery)

### XML with schema validation

* List the Hungarian results
    * Query: [get_hungarians.xquery](get_hungarians.xquery)
    * Schema: [get_hungarians.xsd](get_hungarians.xsd)

* List winners by location
    * Query: [winners_by_location.xquery](winners_by_location.xquery)
    * Schema: [winners_by_location.xsd](winners_by_location.xsd)

* List every gold medal by games
    * Query: [gold_results.xquery](gold_results.xquery)
    * Schema: [gold_results.xsd](gold_results.xsd)

* List every athlete with his/her results
    * Query: [athletes_with_results.xquery](athletes_with_results.xquery)
    * Schema: [athletes_with_results.xsd](athletes_with_results.xsd)

* List every game, inside the games list by genders
    * Query: [games_list.xquery](games_list.xquery)
    * Schema: [games_list.xsd](games_list.xsd)

### HTML

* List countries with its results and medal count in HTML

    * Query: [list_games_html.xquery](list_games_html.xquery)