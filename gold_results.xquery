xquery version "3.1";

import schema default element namespace "" at "gold_results.xsd";

declare variable $file_name := "results.json";

(:
List every gold medal by games
:)

let $data := fn:json-doc($file_name)?*

return 
    validate {
        document {
            <GOLDS>
                {
                    for $games in $data
                    return
                        <GAME name="{$games?name}">
                        {
                        for $game in $games?games?*
                            return 
                                for $result in $game?results?*
                                where $result?medal = 'G'
                                return
                                    <RESULT>
                                        <NAME>{ $result?name }</NAME>
                                        <GENDER>{ $games?gender }</GENDER>
                                        <LOCATION>{ $game?location }</LOCATION>
                                        <YEAR>{ $game?year }</YEAR>
                                    </RESULT>
                        }
                        </GAME>           
                }
            </GOLDS>
        }
    }
