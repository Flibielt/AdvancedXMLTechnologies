xquery version "3.1";

import schema default element namespace "" at "athletes_with_results.xsd";

declare variable $file_name := "results.json";

let $data := fn:json-doc($file_name)?*,
    $athletes := fn:distinct-values($data?games?*?results?*?name)

return 
    validate {
        document {
            <ATHLETES>
                {
                    for $athlete in $athletes
                    return
                        <ATHLETE name="{$athlete}">
                        {
                            for $games in $data
                            return
                                for $game in $games?games?*
                                return 
                                    for $result in $game?results?*
                                    where $result?name eq $athlete
                                    return
                                        <RESULT medal="{$result?medal}">
                                            <LOCATION>{ $game?location }</LOCATION>
                                            <YEAR>{ $game?year }</YEAR>
                                            <GAME>{ $games?name }</GAME>
                                        </RESULT>
                        }
                        </ATHLETE>

                }
            </ATHLETES>
        }
    }
