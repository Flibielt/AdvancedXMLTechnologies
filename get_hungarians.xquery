xquery version "3.1";

import schema default element namespace "" at "get_hungarians.xsd";

declare variable $file_name := "results.json";

(:
List of the Hungarian results
:)

declare function local:get_medal_count($data, $athlete, $medal) as xs:integer
{
    let $count := $data?games?*?results?*[?medal eq $medal][?nationality eq 'HUN'][?name eq $athlete]  => count()
    return $count
};

let $data := fn:json-doc($file_name)?*,
    $athletes := fn:distinct-values($data?games?*?results?*[?nationality eq 'HUN']?name)

return 
    validate {
        document {
            <HUNGARIANS>
                {
                    for $athlete in $athletes
                    order by $athlete
                    return
                        <ATHLETE name="{$athlete}" gold="{local:get_medal_count($data, $athlete, 'G')}" 
                            silver="{local:get_medal_count($data, $athlete, 'S')}" 
                            bronze="{local:get_medal_count($data, $athlete,  'B')}">
                        {
                        for $games in $data
                        return
                            for $game in $games?games?*
                            return 
                                for $result in $game?results?*
                                where $result?nationality eq 'HUN'
                                where $result?name eq $athlete
                                return
                                    <RESULT medal="{$result?medal}">
                                        <GAME>{ $games?name }</GAME>
                                        <LOCATION>{ $game?location }</LOCATION>
                                        <YEAR>{ $game?year }</YEAR>
                                    </RESULT>
                       }
                       </ATHLETE>
                }
            </HUNGARIANS>
        }
    }
